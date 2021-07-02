Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9024B3BA271
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGBPEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 11:04:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:45667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhGBPEM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jul 2021 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625238017;
        bh=zidR5285gxvu2arbyxmhDqg6e5LTCzi9fQLp50nBsWk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DuwxOwI7319Lhx+I9Dc37PZMe6AbuRiW2QGky5FKmFl1Xg9YxF2MVb5pznrGmPGSG
         jDEfrCCNH/5D0owzJ+rQfsut4w+8PVHn04RN3vsa/vy15PQMMDwtv0vo+XZM4BbQRQ
         BbuJ3M+fhEcG2fy8ysO3Su1QGNK3ABFykt/t90p8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1l29Sj2INE-00xaUC; Fri, 02
 Jul 2021 17:00:17 +0200
Date:   Fri, 2 Jul 2021 16:59:54 +0200
From:   John Wood <john.wood@gmx.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v8 3/8] security/brute: Detect a brute force attack
Message-ID: <20210702145954.GA4513@ubuntu>
References: <20210701234807.50453-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701234807.50453-1-alobakin@pm.me>
X-Provags-ID: V03:K1:dlN1ofh6LpaEb5MwTI60oBZZOzpxRydjUFLx8+d3q3xlDqOLQ/g
 AseUQcRVOSgw+y90S5R3RUUGkX4oXSPdXODz7muskTdGNG4XTvD+dI31GrvERxszJqmj3O+
 NGR5HMBSM0ueD0/qczK9UGA5RkFsMcK72AJTDElYA0GJzeW/4Rjit8KMkEtMMq+A508WvZ1
 9CbOiefkEzVVJqbrQIGyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9i/ZvK/cQjw=:a39Z0eLmluy9VDDGJKeaLg
 TvSqt9FDYwL9BX/25PlbGRXeBfVdd3fgvyeCfs3Cp+XW92EKF2euJ/2+8TNV7UogXY/OPVI6H
 FiS43ZCv15Ssd8V0eSkpzvQ5M7jHPHu341L84wtUpSzP0G21MSQnvItwJXbGogBsXNar813oT
 SUjE4WB1mmj64Lhvz5tEcgxk09x+e3yVDtMStATKQafRV93kysgYntaYek7y+rvnVs+Jz9cho
 6ftPnQa7oB+fiBrMlvv18UPBM7FYSf5xmj0eyeAcUEngS6J9NnI7vje+YtPv01oFwp53wRMo7
 Ui1yNLxR6D8tkXq4NAl9MqRVsX0/VbkYgti+7sEL7SXbC8sVtjhNTkCafaP8hGK6fDHserJxV
 6MwKbHRunfIlcT6k/5PukZ7cCcG/lwCBLu1BsGz7mJ/H2qiTr9btN92/xs1280gM/u4bTToHc
 NugNiuR3cZ786M2B2/Qgy6SkwwlRn5b8nIZhWGt30TwI+FU2acVkPZZMqBL7krRB2ftGc32yg
 7qv+UruXZ9hYUEi9NSWXhlv0enDJDSEaFoMuU3WCSKx/hmRDlhI66InBaQMe0FQa8svHAzLFb
 MK7kCn3InBuncnfy+7rF6WUovWzYH51ZqwRXwND50Rbd2KoPpM1AxqVEgql8erI+4ixdfGjSE
 PrB7w+qQCOLJoT6NtZm5wi7RwlrDounjK5jV1+HzoIXxDcJhS1wpkpT6Bjl1YwB0mrvrtJykq
 yc1ExbKWcfNOpVAOiDjblN+wy5gHGKO/aFv+OsZ+RKgENsFFnR/QsUU3bqkuvHtb7u+UEIJxd
 2HQJgnYxNvMR42G6Q8uozh9FR4jXey86VfhsQO/grEelJeTnD+rtyRXSvQxEysyvT1sSqvDKq
 lG1OOsPrGn5mwDQHGHrbZWaqXGfVuCM2SqplAnLo0N2FVoAWq8XZEBa0dW5WNW33PEheDT9L1
 J04TS0Npus+qiII4tcAjQEdRAVaaxJAvqNL9m5HkkZd57G3s8GNl7Wx73D26baD632LFja3Z+
 Ou5+ote2Rp99OhcFduh5OZLItt1JTTby/dwq6pvw7wAYOSQTUoAtVx4/cNM6tHxSm40iEhx/B
 CPtyjW63bPVQErsJmi9gsJiBsN5L7c5lBy1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, Jul 01, 2021 at 11:55:14PM +0000, Alexander Lobakin wrote:
> Hi,
>
> From: John Wood <john.wood@gmx.com>
> Date: Sat, 5 Jun 2021 17:04:00 +0200
>
> > +static int brute_task_execve(struct linux_binprm *bprm, struct file *=
file)
> > +{
> > +	struct dentry *dentry =3D file_dentry(bprm->file);
> > +	struct inode *inode =3D file_inode(bprm->file);
> > +	struct brute_stats stats;
> > +	int rc;
> > +
> > +	inode_lock(inode);
> > +	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
> > +	if (WARN_ON_ONCE(rc && rc !=3D -ENODATA))
> > +		goto unlock;
>
> I think I caught a problem here. Have you tested this with
> initramfs?

No, it has not been tested with initramfs :(

> According to init/do_mount.c's
> init_rootfs()/rootfs_init_fs_context(), when `root=3D` cmdline
> parameter is not empty, kernel creates rootfs of type ramfs
> (tmpfs otherwise).
> The thing about ramfs is that it doesn't support xattrs.

It is a known issue that systems without xattr support are not
suitable for Brute (there are a note in the documentation).
However, the purpose is not to panic the system :(

> I'm running this v8 on a regular PC with initramfs and having
> `root=3D` in cmdline, and Brute doesn't allow the kernel to run
> any init processes (/init, /sbin/init, ...) with err =3D=3D -95
> (-EOPNOTSUPP) -- I'm getting a
>
> WARNING: CPU: 0 PID: 173 at brute_task_execve+0x15d/0x200
> <snip>
> Failed to execute /init (error -95)
>
> and so on (and a panic at the end).
>
> If I omit `root=3D` from cmdline, then the kernel runs init process
> just fine -- I guess because initramfs is then placed inside tmpfs
> with xattr support.
>
> As for me, this ramfs/tmpfs selection based on `root=3D` presence
> is ridiculous and I don't see or know any reasons behind that.
> But that's another story, and ramfs might be not the only one
> system without xattr support.
> I think Brute should have a fallback here, e.g. it could simply
> ignore files from xattr-incapable filesystems instead of such
> WARNING splats and stuff.

Ok, it seems reasonable to me: if the file system doesn't support
xattr, but Brute is enabled, Brute will do nothing and the system
will work normally.

I will work on it for the next version.
Thanks for the feedback.

John Wood
