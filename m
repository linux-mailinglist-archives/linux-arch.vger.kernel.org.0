Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089E286190
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgJGOxc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 10:53:32 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:38088 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgJGOxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 10:53:32 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kQAoq-0002wD-VJ; Wed, 07 Oct 2020 14:53:29 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kQAoo-00017A-KB; Wed, 07 Oct 2020 15:53:28 +0100
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
References: <cover.1601960644.git.thehajime@gmail.com>
 <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
Date:   Wed, 7 Oct 2020 15:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 06/10/2020 10:44, Hajime Tazaki wrote:
> Add basic utility functions for getting a string from a kernel error
> code and a fprintf like function that uses the host print
> operation. The latter is useful for informing the user about errors
> that occur in the host library.
> 
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
>   tools/um/lib/Build     |   4 +
>   tools/um/lib/jmp_buf.c |  14 +++
>   tools/um/lib/jmp_buf.h |   8 ++
>   tools/um/lib/utils.c   | 210 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 236 insertions(+)
>   create mode 100644 tools/um/lib/Build
>   create mode 100644 tools/um/lib/jmp_buf.c
>   create mode 100644 tools/um/lib/jmp_buf.h
>   create mode 100644 tools/um/lib/utils.c
> 
> diff --git a/tools/um/lib/Build b/tools/um/lib/Build
> new file mode 100644
> index 000000000000..fc967af4104a
> --- /dev/null
> +++ b/tools/um/lib/Build
> @@ -0,0 +1,4 @@
> +include $(objtree)/include/config/auto.conf
> +
> +liblinux-$(CONFIG_UMMODE_LIB) += utils.o
> +liblinux-$(CONFIG_UMMODE_LIB) += jmp_buf.o
> diff --git a/tools/um/lib/jmp_buf.c b/tools/um/lib/jmp_buf.c
> new file mode 100644
> index 000000000000..f6bdd7e4bd83
> --- /dev/null
> +++ b/tools/um/lib/jmp_buf.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <setjmp.h>
> +#include <lkl_host.h>
> +
> +void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void))
> +{
> +	if (!setjmp(*((jmp_buf *)jmpb->buf)))
> +		f();
> +}
> +
> +void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val)
> +{
> +	longjmp(*((jmp_buf *)jmpb->buf), val);
> +}
> diff --git a/tools/um/lib/jmp_buf.h b/tools/um/lib/jmp_buf.h
> new file mode 100644
> index 000000000000..8782cbaaf51f
> --- /dev/null
> +++ b/tools/um/lib/jmp_buf.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LKL_LIB_JMP_BUF_H
> +#define _LKL_LIB_JMP_BUF_H
> +
> +void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void));
> +void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val);
> +
> +#endif
> diff --git a/tools/um/lib/utils.c b/tools/um/lib/utils.c
> new file mode 100644
> index 000000000000..4930479a8a35
> --- /dev/null
> +++ b/tools/um/lib/utils.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <lkl_host.h>

These are actually different on different architectures. These look like the x86 values.

IMHO a kernel strerror() would be the right way of dealing with this in the long term (i understand that we cannot call the platform one, because it may be different from the internal Linux errors). It will be useful in a lot of other places.

If we leave it as is, we need to make this arch specific at some point.

> +
> +static const char * const lkl_err_strings[] = {
> +	"Success",
> +	"Operation not permitted",
> +	"No such file or directory",
> +	"No such process",
> +	"Interrupted system call",
> +	"I/O error",
> +	"No such device or address",
> +	"Argument list too long",
> +	"Exec format error",
> +	"Bad file number",
> +	"No child processes",
> +	"Try again",
> +	"Out of memory",
> +	"Permission denied",
> +	"Bad address",
> +	"Block device required",
> +	"Device or resource busy",
> +	"File exists",
> +	"Cross-device link",
> +	"No such device",
> +	"Not a directory",
> +	"Is a directory",
> +	"Invalid argument",
> +	"File table overflow",
> +	"Too many open files",
> +	"Not a typewriter",
> +	"Text file busy",
> +	"File too large",
> +	"No space left on device",
> +	"Illegal seek",
> +	"Read-only file system",
> +	"Too many links",
> +	"Broken pipe",
> +	"Math argument out of domain of func",
> +	"Math result not representable",
> +	"Resource deadlock would occur",
> +	"File name too long",
> +	"No record locks available",
> +	"Invalid system call number",
> +	"Directory not empty",
> +	"Too many symbolic links encountered",
> +	"Bad error code", /* EWOULDBLOCK is EAGAIN */
> +	"No message of desired type",
> +	"Identifier removed",
> +	"Channel number out of range",
> +	"Level 2 not synchronized",
> +	"Level 3 halted",
> +	"Level 3 reset",
> +	"Link number out of range",
> +	"Protocol driver not attached",
> +	"No CSI structure available",
> +	"Level 2 halted",
> +	"Invalid exchange",
> +	"Invalid request descriptor",
> +	"Exchange full",
> +	"No anode",
> +	"Invalid request code",
> +	"Invalid slot",
> +	"Bad error code", /* EDEADLOCK is EDEADLK */
> +	"Bad font file format",
> +	"Device not a stream",
> +	"No data available",
> +	"Timer expired",
> +	"Out of streams resources",
> +	"Machine is not on the network",
> +	"Package not installed",
> +	"Object is remote",
> +	"Link has been severed",
> +	"Advertise error",
> +	"Srmount error",
> +	"Communication error on send",
> +	"Protocol error",
> +	"Multihop attempted",
> +	"RFS specific error",
> +	"Not a data message",
> +	"Value too large for defined data type",
> +	"Name not unique on network",
> +	"File descriptor in bad state",
> +	"Remote address changed",
> +	"Can not access a needed shared library",
> +	"Accessing a corrupted shared library",
> +	".lib section in a.out corrupted",
> +	"Attempting to link in too many shared libraries",
> +	"Cannot exec a shared library directly",
> +	"Illegal byte sequence",
> +	"Interrupted system call should be restarted",
> +	"Streams pipe error",
> +	"Too many users",
> +	"Socket operation on non-socket",
> +	"Destination address required",
> +	"Message too long",
> +	"Protocol wrong type for socket",
> +	"Protocol not available",
> +	"Protocol not supported",
> +	"Socket type not supported",
> +	"Operation not supported on transport endpoint",
> +	"Protocol family not supported",
> +	"Address family not supported by protocol",
> +	"Address already in use",
> +	"Cannot assign requested address",
> +	"Network is down",
> +	"Network is unreachable",
> +	"Network dropped connection because of reset",
> +	"Software caused connection abort",
> +	"Connection reset by peer",
> +	"No buffer space available",
> +	"Transport endpoint is already connected",
> +	"Transport endpoint is not connected",
> +	"Cannot send after transport endpoint shutdown",
> +	"Too many references: cannot splice",
> +	"Connection timed out",
> +	"Connection refused",
> +	"Host is down",
> +	"No route to host",
> +	"Operation already in progress",
> +	"Operation now in progress",
> +	"Stale file handle",
> +	"Structure needs cleaning",
> +	"Not a XENIX named type file",
> +	"No XENIX semaphores available",
> +	"Is a named type file",
> +	"Remote I/O error",
> +	"Quota exceeded",
> +	"No medium found",
> +	"Wrong medium type",
> +	"Operation Canceled",
> +	"Required key not available",
> +	"Key has expired",
> +	"Key has been revoked",
> +	"Key was rejected by service",
> +	"Owner died",
> +	"State not recoverable",
> +	"Operation not possible due to RF-kill",
> +	"Memory page has hardware error",
> +};
> +
> +const char *lkl_strerror(int err)
> +{
> +	if (err < 0)
> +		err = -err;
> +
> +	if ((size_t)err >= sizeof(lkl_err_strings) / sizeof(const char *))
> +		return "Bad error code";
> +
> +	return lkl_err_strings[err];
> +}
> +
> +void lkl_perror(char *msg, int err)
> +{
> +	const char *err_msg = lkl_strerror(err);
> +	/* We need to use 'real' printf because lkl_host_ops.print can
> +	 * be turned off when debugging is off.
> +	 */
> +	lkl_printf("%s: %s\n", msg, err_msg);
> +}
> +
> +static int lkl_vprintf(const char *fmt, va_list args)
> +{
> +	int n;
> +	char *buffer;
> +	va_list copy;
> +
> +	if (!lkl_host_ops.print)
> +		return 0;
> +
> +	va_copy(copy, args);
> +	n = vsnprintf(NULL, 0, fmt, copy);
> +	va_end(copy);
> +
> +	buffer = lkl_host_ops.mem_alloc(n + 1);
> +	if (!buffer)
> +		return (-1);
> +
> +	vsnprintf(buffer, n + 1, fmt, args);
> +
> +	lkl_host_ops.print(buffer, n);
> +	lkl_host_ops.mem_free(buffer);
> +
> +	return n;
> +}
> +
> +int lkl_printf(const char *fmt, ...)
> +{
> +	int n;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	n = lkl_vprintf(fmt, args);
> +	va_end(args);
> +
> +	return n;
> +}
> +
> +void lkl_bug(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	lkl_vprintf(fmt, args);
> +	va_end(args);
> +
> +	lkl_host_ops.panic();
> +}
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
