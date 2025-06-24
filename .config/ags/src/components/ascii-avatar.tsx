import GLib from "gi://GLib";


interface AsciiAvatarProps {
  image: string;
  size?: number;
}


export default function AsciiAvatar({ image, size = 90 }: AsciiAvatarProps) {
    const [success, ascii_avatar]  = GLib.file_get_contents(image);
    if (!success) {
        console.error("Failed to read avatar file");
    }
    const avatar = new TextDecoder("utf-8").decode(ascii_avatar);

    // const css = `
    //     background-size: cover;
    //     background-repeat: no-repeat;
    //     background-position: center;
    //     min-height: ${size}px;
    //     min-width: ${size}px;
    //     border-radius: 8px;
    // `;
    return <button className="ascii-avatar"  label={avatar} />;
}
