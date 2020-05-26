Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD59E1A220B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgDHM3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:29:54 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:58392 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgDHM3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:29:54 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 08:29:51 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48y3Ng2756zKmXF;
        Wed,  8 Apr 2020 14:24:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id aeR4DgY25IJL; Wed,  8 Apr 2020 14:23:59 +0200 (CEST)
Date:   Wed, 8 Apr 2020 22:23:30 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Message-ID: <20200408122330.5vorg2bwtth2dp5k@yavin.dot.cyphar.com>
References: <cover.1586321767.git.josh@joshtriplett.org>
 <e598110f71a4e2346860b94e91de3e6e75a4b82a.1586321767.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g42ofxvuss5e5opy"
Content-Disposition: inline
In-Reply-To: <e598110f71a4e2346860b94e91de3e6e75a4b82a.1586321767.git.josh@joshtriplett.org>
X-Rspamd-Queue-Id: CA674176B
X-Rspamd-Score: -8.63 / 15.00 / 15.00
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--g42ofxvuss5e5opy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-07, Josh Triplett <josh@joshtriplett.org> wrote:
> Inspired by the X protocol's handling of XIDs, allow userspace to select
> the file descriptor opened by openat2, so that it can use the resulting
> file descriptor in subsequent system calls without waiting for the
> response to openat2.
>=20
> In io_uring, this allows sequences like openat2/read/close without
> waiting for the openat2 to complete. Multiple such sequences can
> overlap, as long as each uses a distinct file descriptor.
>=20
> Add a new O_SPECIFIC_FD open flag to enable this behavior, only accepted
> by openat2 for now (ignored by open/openat like all unknown flags). Add
> an fd field to struct open_how (along with appropriate padding, and
> verify that the padding is 0 to allow replacing the padding with a field
> in the future).
>=20
> The file table has a corresponding new function
> get_specific_unused_fd_flags, which gets the specified file descriptor
> if O_SPECIFIC_FD is set (and the fd isn't -1); otherwise it falls back
> to get_unused_fd_flags, to simplify callers.

>=20
> The specified file descriptor must not already be open; if it is,
> get_specific_unused_fd_flags will fail with -EBUSY. This helps catch
> userspace errors.
>=20
> When O_SPECIFIC_FD is set, and fd is not -1, openat2 will use the
> specified file descriptor rather than finding the lowest available one.
>=20
> Test program:
>=20
>     #include <err.h>
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <unistd.h>
>=20
>     int main(void)
>     {
>         struct open_how how =3D {
> 	    .flags =3D O_RDONLY | O_SPECIFIC_FD,
> 	    .fd =3D 42
> 	};
>         int fd =3D openat2(AT_FDCWD, "/dev/null", &how, sizeof(how));
>         if (fd < 0)
>             err(1, "openat2");
>         printf("fd=3D%d\n", fd); // prints fd=3D42
>         return 0;
>     }
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Maybe I'm misunderstanding something, but this Signed-off-by looks
strange -- was it Co-developed-by Jens?

> ---
>  fs/fcntl.c                       |  2 +-
>  fs/file.c                        | 39 ++++++++++++++++++++++++++++++++
>  fs/io_uring.c                    |  3 ++-
>  fs/open.c                        |  6 +++--
>  include/linux/fcntl.h            |  5 ++--
>  include/linux/file.h             |  3 +++
>  include/uapi/asm-generic/fcntl.h |  4 ++++
>  include/uapi/linux/openat2.h     |  2 ++
>  8 files changed, 58 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 2e4c0fa2074b..0357ad667563 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1033,7 +1033,7 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=3D
>  		HWEIGHT32(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC | __FMODE_NONOTIFY));
> diff --git a/fs/file.c b/fs/file.c
> index ba06140d89af..0c34206314dc 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -567,6 +567,45 @@ void put_unused_fd(unsigned int fd)
> =20
>  EXPORT_SYMBOL(put_unused_fd);
> =20
> +int __get_specific_unused_fd_flags(unsigned int fd, unsigned int flags,
> +				   unsigned long nofile)
> +{
> +	int ret;
> +	struct fdtable *fdt;
> +	struct files_struct *files =3D current->files;
> +
> +	if (!(flags & O_SPECIFIC_FD) || fd =3D=3D -1)
> +		return __get_unused_fd_flags(flags, nofile);

This check should just be (flags & O_SPECIFIC_FD) -- see my comment
below about ->fd being negative.

> +
> +	if (fd >=3D nofile)
> +		return -EBADF;
> +
> +	spin_lock(&files->file_lock);
> +	ret =3D expand_files(files, fd);
> +	if (unlikely(ret < 0))
> +		goto out_unlock;
> +	fdt =3D files_fdtable(files);
> +	if (fdt->fd[fd]) {
> +		ret =3D -EBUSY;
> +		goto out_unlock;

It would be remiss of me to not mention that this is inconsistent with
the other way of explicitly picking a file descriptor on Unix -- the dup
family closes newfd if it's already used.

But that being said, I do actually prefer this behaviour since it means
that two threads trying to open a file with the same specific file
descriptor won't see the file descriptor change underneath them (leading
to who knows how much head-scratching).

> +	}
> +	__set_open_fd(fd, fdt);
> +	if (flags & O_CLOEXEC)
> +		__set_close_on_exec(fd, fdt);
> +	else
> +		__clear_close_on_exec(fd, fdt);
> +	ret =3D fd;
> +
> +out_unlock:
> +	spin_unlock(&files->file_lock);
> +	return ret;
> +}
> +
> +int get_specific_unused_fd_flags(unsigned int fd, unsigned int flags)
> +{
> +	return __get_specific_unused_fd_flags(fd, flags, rlimit(RLIMIT_NOFILE));
> +}
> +
>  /*
>   * Install a file pointer in the fd array.
>   *
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 358f97be9c7b..4a69e1daf3fe 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2997,7 +2997,8 @@ static int io_openat2(struct io_kiocb *req, bool fo=
rce_nonblock)
>  	if (ret)
>  		goto err;
> =20
> -	ret =3D __get_unused_fd_flags(req->open.how.flags, req->open.nofile);
> +	ret =3D __get_specific_unused_fd_flags(req->open.how.fd,
> +			req->open.how.flags, req->open.nofile);
>  	if (ret < 0)
>  		goto err;
> =20
> diff --git a/fs/open.c b/fs/open.c
> index 719b320ede52..d4225e6f9d4c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -958,7 +958,7 @@ EXPORT_SYMBOL(open_with_fake_path);
>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
>  	struct open_how how =3D {
> -		.flags =3D flags & VALID_OPEN_FLAGS,
> +		.flags =3D flags & VALID_OPEN_FLAGS & ~O_SPECIFIC_FD,

This is getting a little ugly, maybe filter out O_SPECIFIC_FD later on
in build_open_how() -- where we handle O_PATH.

>  		.mode =3D mode & S_IALLUGO,
>  	};
> =20
> @@ -1143,7 +1143,7 @@ static long do_sys_openat2(int dfd, const char __us=
er *filename,
>  	if (IS_ERR(tmp))
>  		return PTR_ERR(tmp);
> =20
> -	fd =3D get_unused_fd_flags(how->flags);
> +	fd =3D get_specific_unused_fd_flags(how->fd, how->flags);
>  	if (fd >=3D 0) {
>  		struct file *f =3D do_filp_open(dfd, tmp, &op);
>  		if (IS_ERR(f)) {
> @@ -1193,6 +1193,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __use=
r *, filename,
>  	err =3D copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
>  	if (err)
>  		return err;
> +	if (tmp.pad !=3D 0)
> +		return -EINVAL;

This check should be done in build_open_flags(), where the other sanity
checks are done. In addition, there must be an additional check like

  if (!(flags & O_SPECIFIC_FD) && how->fd !=3D 0)
    return -EINVAL;

Since we must not allow garbage values to be passed and ignored by us in
openat2().

>  	/* O_LARGEFILE is only allowed for non-O_PATH. */
>  	if (!(tmp.flags & O_PATH) && force_o_largefile())
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 7bcdcf4f6ab2..728849bcd8fa 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC |=
 \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_SPECIFIC_FD)
> =20
>  /* List of all valid flags for the how->upgrade_mask argument: */
>  #define VALID_UPGRADE_FLAGS \
> @@ -23,7 +23,8 @@
> =20
>  /* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> -#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
> +#define OPEN_HOW_SIZE_VER1	32 /* added fd and pad */
> +#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER1
> =20
>  #ifndef force_o_largefile
>  #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> diff --git a/include/linux/file.h b/include/linux/file.h
> index b67986f818d2..a63301864a36 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -87,6 +87,9 @@ extern void set_close_on_exec(unsigned int fd, int flag=
);
>  extern bool get_close_on_exec(unsigned int fd);
>  extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
>  extern int get_unused_fd_flags(unsigned flags);
> +extern int __get_specific_unused_fd_flags(unsigned int fd, unsigned int =
flags,
> +	unsigned long nofile);
> +extern int get_specific_unused_fd_flags(unsigned int fd, unsigned int fl=
ags);
>  extern void put_unused_fd(unsigned int fd);
>  extern unsigned int increase_min_fd(unsigned int num);
> =20
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 9dc0bf0c5a6e..d3de5b8b3955 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -89,6 +89,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef O_SPECIFIC_FD
> +#define O_SPECIFIC_FD	01000000000	/* open as specified fd */
> +#endif

Maybe you've already done this (since you skipped several bits in the
O_* flag space), but I would double-check that there is no conflict on
other architectures. I faintly recall that FMODE_NOTIFY has a different
value on sparc, and there was some oddness on alpha too... But as long
as fcntl.c builds on all the arches then it's fine.

> +
>  /* a horrid kludge trying to make sure that this will fail on old kernel=
s */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
>  #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)     =20
> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index 58b1eb711360..50d1206b64c2 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -20,6 +20,8 @@ struct open_how {
>  	__u64 flags;
>  	__u64 mode;
>  	__u64 resolve;
> +	__s32 fd;
> +	__u32 pad; /* Must be 0 in the current version */

I'm not sure I see why the new field is an s32 -- there should be no
situation where a user specifies O_SPECIFIC_FD and a negative file
descriptor (if we keep it as an s32, you should get an -EINVAL in that
case). If you don't want O_SPECIFIC_FD, don't specify it.

But I think this should be a u32. I'm tempted to argue this should
actually be a u64, but nothing supports 64-bit file descriptor numbers
(including the return type of openat2).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--g42ofxvuss5e5opy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXo3COgAKCRCdlLljIbnQ
EpiUAP9L1qbz1jxK+FpDvuNLGGMxQ3XYNLEQncuNQoU7W+kf4gD9EzA2zojfrPzU
RwMvoO5TUzUsu+lGQr1yP3CeUAjcpQI=
=IjzP
-----END PGP SIGNATURE-----

--g42ofxvuss5e5opy--
