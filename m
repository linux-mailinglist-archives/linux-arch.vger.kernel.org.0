Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1063BA37B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhGBRK5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 13:10:57 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:49071 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhGBRK5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 13:10:57 -0400
Date:   Fri, 02 Jul 2021 17:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1625245700; bh=a0dudNCpkGNtNs8mdjq6tTFehahgFVidBNRIuz7OjCA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=OYI87hmgH9uYNSM5t4lU/NNQo3sJaYP9fT5Vmf6J9UfUBbwRubxTiOaA5oIgZdeMg
         rZfx3gOyUHAFNgjXmc90FY076J4hY8ooMAisTyqv0w50mLmRnBxcKvYasf6KudQWQv
         unTgefwKKloAKAPoGymRwa1YMIwOlG2QYFRbYztg7bOPks6YIfLs39OdXtcKxrZSqS
         F7Ag+3nHMB6AdNZVa9n+1Hx6V/LsJxFhEjrFP88+2RlMIFxPlVclPv4IrIx9sf1x4z
         nZ7Ec5JaiK67CM8ZJ44/7woOg/aMUQ1rnhH6HIdD6dFhOPIUNY7Z+4DUyMuQfwi8Jn
         NGPMBYtoY8uhQ==
To:     John Wood <john.wood@gmx.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v8 3/8] security/brute: Detect a brute force attack
Message-ID: <20210702170101.16116-1-alobakin@pm.me>
In-Reply-To: <20210702145954.GA4513@ubuntu>
References: <20210701234807.50453-1-alobakin@pm.me> <20210702145954.GA4513@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: John Wood <john.wood@gmx.com>
Date: Fri, 2 Jul 2021 16:59:54 +0200

> Hi,
>
> On Thu, Jul 01, 2021 at 11:55:14PM +0000, Alexander Lobakin wrote:
> > Hi,
> >
> > From: John Wood <john.wood@gmx.com>
> > Date: Sat, 5 Jun 2021 17:04:00 +0200
> >
> > > +static int brute_task_execve(struct linux_binprm *bprm, struct file =
*file)
> > > +{
> > > +=09struct dentry *dentry =3D file_dentry(bprm->file);
> > > +=09struct inode *inode =3D file_inode(bprm->file);
> > > +=09struct brute_stats stats;
> > > +=09int rc;
> > > +
> > > +=09inode_lock(inode);
> > > +=09rc =3D brute_get_xattr_stats(dentry, inode, &stats);
> > > +=09if (WARN_ON_ONCE(rc && rc !=3D -ENODATA))
> > > +=09=09goto unlock;
> >
> > I think I caught a problem here. Have you tested this with
> > initramfs?
>
> No, it has not been tested with initramfs :(
>
> > According to init/do_mount.c's
> > init_rootfs()/rootfs_init_fs_context(), when `root=3D` cmdline
> > parameter is not empty, kernel creates rootfs of type ramfs
> > (tmpfs otherwise).
> > The thing about ramfs is that it doesn't support xattrs.
>
> It is a known issue that systems without xattr support are not
> suitable for Brute (there are a note in the documentation).
> However, the purpose is not to panic the system :(
>
> > I'm running this v8 on a regular PC with initramfs and having
> > `root=3D` in cmdline, and Brute doesn't allow the kernel to run
> > any init processes (/init, /sbin/init, ...) with err =3D=3D -95
> > (-EOPNOTSUPP) -- I'm getting a
> >
> > WARNING: CPU: 0 PID: 173 at brute_task_execve+0x15d/0x200
> > <snip>
> > Failed to execute /init (error -95)
> >
> > and so on (and a panic at the end).
> >
> > If I omit `root=3D` from cmdline, then the kernel runs init process
> > just fine -- I guess because initramfs is then placed inside tmpfs
> > with xattr support.
> >
> > As for me, this ramfs/tmpfs selection based on `root=3D` presence
> > is ridiculous and I don't see or know any reasons behind that.
> > But that's another story, and ramfs might be not the only one
> > system without xattr support.
> > I think Brute should have a fallback here, e.g. it could simply
> > ignore files from xattr-incapable filesystems instead of such
> > WARNING splats and stuff.
>
> Ok, it seems reasonable to me: if the file system doesn't support
> xattr, but Brute is enabled, Brute will do nothing and the system
> will work normally.

On the other hand, it leaves a potentional window for attackers to
perform brute force from xattr-incapable filesystems. So at the end
of the day I think that the current implementation (a strong
rejection of such filesystems) is way more secure than having
a fallback I proposed.

I'm planning to make a patch which will eliminate such weird rootfs
type selection and just always use more feature-rich tmpfs if it's
compiled in. So, as an alternative, you could add it to your series
as a preparatory change and just add a Kconfig dependency on
CONFIG_TMPFS && CONFIG_TMPFS_XATTR to CONFIG_SECURITY_FORK_BRUTE
without messing with any fallbacks at all.
What do you think?

> I will work on it for the next version.
> Thanks for the feedback.
>
> John Wood

Thanks,
Al

