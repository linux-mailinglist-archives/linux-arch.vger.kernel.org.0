Return-Path: <linux-arch+bounces-7456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA2986FF3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 11:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF09A1F216E1
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61B1A7AF0;
	Thu, 26 Sep 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="EFeVnH22"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5531A4F18;
	Thu, 26 Sep 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342565; cv=none; b=hwXGs9Z9sHDWXlzZc49Mu+9OklUN2Ywuw/qh5ko6m9tq1l/GHTS1CBsqAyNlz1fmgfGPNEz2nTMCNQ00AKjttsTAwmkqnHTo9pTmTRGe2ayBHuv3K9gmIFVPP1RnWJzoByuPxovGLgVmGWDj/2IZ1wKTgZHdt8SrHF3ZS5AsN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342565; c=relaxed/simple;
	bh=g/qEmGKzaw+H0PJZ7Jq4eKGS1nJ7s2i4i6vOJOhMMmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEQl02Q6aL4Pkw1K490iGJY3VLSF1EuwiYeAxpGQ9fvFOA1fQnidlTsCMe4ckNNJZN593LNvitfO3cHxmqSISS2FZQpPds6dfctQDqEuWwA8WI5BQdFVMyy6SpQh+IYhIPF2BYoXk9yplmMqRYKceGG6+0Vv/pKMryYE0RCX5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=EFeVnH22; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727342521; x=1727947321; i=deller@gmx.de;
	bh=fK8D4anG++VQfYV7RQFyfXZI4RbsCsLG7Bg0m1QFYs0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EFeVnH22LQuLAQEyum005QZ6OeHS0IKnMYvnC12/bAQsnfuE/Jfekp0VJVD7nart
	 pMPxMFQZrvzBBHkHgYqNMvgVXvIQSRtbezHKBnBndsYnK1HIJAKPm2SgmHsJHB3IC
	 yUliF97EGqrccP3OsfRRjd1TEnSrvh98SzKa+O/V/T43zlTCJL8yu3c//IYtAWveH
	 sa3IFWBYM5BWJ8WTt4Gzw9sPOJHRGjmRpznncABkiNMwxxmYdJ15X6CSbZB66aNB6
	 QHPqHn5A6NT3d73r8fI9QcxqWXYyLsJLh8fUHOjGydwz3kWElJY4MfaDyw7nx8aFW
	 anYr7MW1QcePXjOnzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1sNcqL2wdh-00SYXv; Thu, 26
 Sep 2024 11:22:00 +0200
Message-ID: <b27eb97b-cb76-4fa8-8b8a-66d3bec655ae@gmx.de>
Date: Thu, 26 Sep 2024 11:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] asm-generic: cosmetic updates to uapi/asm/mman.h
To: Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Damien Le Moal <dlemoal@kernel.org>, David Hildenbrand <david@redhat.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Kees Cook <kees@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-2-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240925210615.2572360-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HBJiicMOkwCkT3OfqQB6llMXeigneNaSiMoNKO5SaWSQ0C1aSEb
 w4OsjvHbC61vm+32m3dtSQHUW0V6v8b7gAKBAcqxXRL7ocoXi6e15qteany9sLOs5GA2ELl
 4KxAjinT0w9J3xCmMyKyoznyVlKyfkka/xFysOG+9AFpuxFggA4l5J5sBWAbgWpSp+GHc9d
 ltDhBRGjaMZ64oWggFIrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pv4bYgTtFS0=;0Bw5BkGY/bj+lojD8zuCvpMTXgN
 uwY9w4AoVWnZMIqcbMze06gpE0qFMAHOJPaQ0wr5lIVQAude7G0V1BQDtwe5jNVUF6VL6QcGJ
 WXf2P7kO3QahaNpGkFpmr6YihV0CHbTeDOwJ8BHv1T/QV3WyQxruCiAd3rp0VR1Ol0IRYjzNS
 Zx292kahTjcqnA7YDdinkDUltsPu6fMHNTNGxSFxs7T0DQ3AXOlC41ynqNBUS2b19n7Dloq5P
 uL+ViSqHOiAk/vciOYICAMY5rFdI2u0kEAgQEjU1weS72czGjJEm+HHPNleq01e9IrPqob0UP
 EaBw+6hK5BOj8LZzfgCiBKPzrJ2DFIgEL8u1H5YWmEQP60I0bM3kpy8kDaLJYu6wrdCzRubYu
 /cf0uopaJkxd7m3jMpyr4sPZtpijqVdGtOZYoOG0Sjqxse6ZoAh4UnkCoQuICZV2NTpVJvQ0+
 HH54NRiNbaEciixqlmZu0jyjjD8f5/V4CaGtJs5gLcmX41MmEQSI5y90jq1y6POLJ3del4BmM
 nIZkIvf2SuOIlMQFghAqAS4TbjuvTjXl4/s1hNi18IPfO/G284YVm3/oVVj3bbMuwS5GzMrsN
 gLtjHj6kI40eBUoZrKy55fVx1tYIHrvWZfndjoqqUnpAKeWlA3XDYpB8Co6B0+70idVxAJRof
 eoIpRvyZHHg9BtCWbNqbjOHvc2hDsIJLk7pr3Yl/FXDowB5HmDTOl6y3YAz678Fc3GuSP5l26
 NajQ6zD/EvogJFayytofAF/OXHIVTnFFSqwB61JRXhnrlYYr2+FuBblCp5fFCPyGVPeDx8Ui4
 8jY8Rj3FNfX6iz7ulE5FCdXcwHePViKFfjRjYNtE3z5/I=

On 9/25/24 23:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All but four architectures use asm-generic/mman-common.h, and the
> differences between these are mostly accidental. Rearrange them
> slightly to make it possible to 'vimdiff' them to see the actual
> relevant differences:
>
>   - Move MADV_HWPOISON/MADV_SOFT_OFFLINE to the end of the list
>     and ensure that all architectures include definitions
>
>   - Use the exact same amount of whitespace and leading digits
>     in each architecture
>
>   - Synchronize comments, replacing historic defines that were
>     never used with appropriate comments
>
>   - explicitly point out MAP_SYNC and MAP_UNINITIALIZED as
>     unsupported
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/alpha/include/uapi/asm/mman.h     | 53 ++++++++++++-------
>   arch/mips/include/uapi/asm/mman.h      | 72 ++++++++++++--------------
>   arch/parisc/include/uapi/asm/mman.h    | 50 +++++++++++-------
>   arch/xtensa/include/uapi/asm/mman.h    | 61 ++++++++++------------
>   include/uapi/asm-generic/mman-common.h |  8 ++-
>   5 files changed, 129 insertions(+), 115 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uap=
i/asm/mman.h
> index 763929e814e9..8946a13ce858 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -6,6 +6,8 @@
>   #define PROT_WRITE	0x2		/* page can be written */
>   #define PROT_EXEC	0x4		/* page can be executed */
>   #define PROT_SEM	0x8		/* page may be used for atomic ops */
> +/*			0x10		   reserved for arch-specific use */
> +/*			0x20		   reserved for arch-specific use */
>   #define PROT_NONE	0x0		/* page can not be accessed */
>   #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to s=
tart of growsdown vma */
>   #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end=
 of growsup vma */
> @@ -15,41 +17,49 @@
>   #define MAP_FIXED	0x100		/* Interpret addr exactly */
>   #define MAP_ANONYMOUS	0x10		/* don't use a file */
>
> -/* not used by linux, but here to make sure we don't clash with OSF/1 d=
efines */
> -#define _MAP_HASSEMAPHORE 0x0200
> -#define _MAP_INHERIT	0x0400
> -#define _MAP_UNALIGNED	0x0800

I suggest to keep ^^ those. It's useful information which isn't
easily visible otherwise.


> -/* These are linux-specific */
> -#define MAP_GROWSDOWN	0x01000		/* stack-like segment */
> -#define MAP_DENYWRITE	0x02000		/* ETXTBSY */
> -#define MAP_EXECUTABLE	0x04000		/* mark it as an executable */
> -#define MAP_LOCKED	0x08000		/* lock the mapping */
> +/* 0x200 through 0x800 originally for OSF-1 compat */
> +#define MAP_GROWSDOWN	0x1000		/* stack-like segment */
> +#define MAP_DENYWRITE	0x2000		/* ETXTBSY */
> +#define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
> +#define MAP_LOCKED	0x8000		/* pages are locked */
>   #define MAP_NORESERVE	0x10000		/* don't check for reservations */
> -#define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x40000		/* do not block on IO */
> -#define MAP_STACK	0x80000		/* give out an address that is best suited f=
or process/thread stacks */
> -#define MAP_HUGETLB	0x100000	/* create a huge page mapping */
> +
> +#define MAP_POPULATE		0x020000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x040000	/* do not block on IO */
> +#define MAP_STACK		0x080000	/* give out an address that is best suited =
for process/thread stacks */
> +#define MAP_HUGETLB		0x100000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
>   #define MAP_FIXED_NOREPLACE	0x200000/* MAP_FIXED which doesn't unmap u=
nderlying mapping */
>
> -#define MS_ASYNC	1		/* sync memory asynchronously */
> -#define MS_SYNC		2		/* synchronous memory sync */
> -#define MS_INVALIDATE	4		/* invalidate the caches */
> +/* MAP_UNINITIALIZED not supported */
>
> +/*
> + * Flags for mlockall
> + */
>   #define MCL_CURRENT	 8192		/* lock all currently mapped pages */
>   #define MCL_FUTURE	16384		/* lock all additions to address space */
>   #define MCL_ONFAULT	32768		/* lock all pages that are faulted in */
>
> +/*
> + * Flags for mlock
> + */
>   #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faul=
ted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_SYNC		2		/* synchronous memory sync */
> +#define MS_INVALIDATE	4		/* invalidate the caches */
> +
>   #define MADV_NORMAL	0		/* no further special treatment */
>   #define MADV_RANDOM	1		/* expect random page references */
>   #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>   #define MADV_WILLNEED	3		/* will need these pages */
> -#define	MADV_SPACEAVAIL	5		/* ensure resources are available */
>   #define MADV_DONTNEED	6		/* don't need these pages */
> +/* originally MADV_SPACEAVAIL 5 */
>
> -/* common/generic parameters */
> +/* common parameters: try to keep these consistent across architectures=
 */
>   #define MADV_FREE	8		/* free pages only if memory pressure */
>   #define MADV_REMOVE	9		/* remove these pages & resources */
>   #define MADV_DONTFORK	10		/* don't inherit across fork */
> @@ -63,7 +73,7 @@
>
>   #define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>   					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>   #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>   #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -78,6 +88,9 @@
>
>   #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>   /* compatibility flags */
>   #define MAP_FILE	0
>
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/=
asm/mman.h
> index 9c48d9a21aa0..399937cefaa6 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -9,53 +9,36 @@
>   #ifndef _ASM_MMAN_H
>   #define _ASM_MMAN_H
>
> -/*
> - * Protections are chosen from these bits, OR'd together.  The
> - * implementation does not necessarily support PROT_EXEC or PROT_WRITE
> - * without PROT_READ.  The only guarantees are that no writing will be
> - * allowed without PROT_WRITE and no access will be allowed for PROT_NO=
NE.
> - */
> -#define PROT_NONE	0x00		/* page can not be accessed */
> -#define PROT_READ	0x01		/* page can be read */
> -#define PROT_WRITE	0x02		/* page can be written */
> -#define PROT_EXEC	0x04		/* page can be executed */
> -/*			0x08		   reserved for PROT_EXEC_NOFLUSH */
> +#define PROT_READ	0x1		/* page can be read */
> +#define PROT_WRITE	0x2		/* page can be written */
> +#define PROT_EXEC	0x4		/* page can be executed */
> +/*			0x8		   reserved for PROT_EXEC_NOFLUSH */
>   #define PROT_SEM	0x10		/* page may be used for atomic ops */
> +/*			0x20		   reserved for arch-specific use */
> +#define PROT_NONE	0x0		/* page can not be accessed */
>   #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to s=
tart of growsdown vma */
>   #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end=
 of growsup vma */
>
> -/*
> - * Flags for mmap
> - */
>   /* 0x01 - 0x03 are defined in linux/mman.h */
> -#define MAP_TYPE	0x00f		/* Mask for type of mapping */
> -#define MAP_FIXED	0x010		/* Interpret addr exactly */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
>
> -/* not used by linux, but here to make sure we don't clash with ABI def=
ines */
> -#define MAP_RENAME	0x020		/* Assign page to file */
> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */

same here. I think they should be preserved.


> -
> -/* These are linux-specific */
> +/* 0x20 through 0x100 originally reserved for other unix compat */
>   #define MAP_NORESERVE	0x0400		/* don't check for reservations */
>   #define MAP_ANONYMOUS	0x0800		/* don't use a file */
>   #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
>   #define MAP_DENYWRITE	0x2000		/* ETXTBSY */
>   #define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
>   #define MAP_LOCKED	0x8000		/* pages are locked */
> -#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x20000		/* do not block on IO */
> -#define MAP_STACK	0x40000		/* give out an address that is best suited f=
or process/thread stacks */
> -#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> -#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap u=
nderlying mapping */
>
> -/*
> - * Flags for msync
> - */
> -#define MS_ASYNC	0x0001		/* sync memory asynchronously */
> -#define MS_INVALIDATE	0x0002		/* invalidate mappings & caches */
> -#define MS_SYNC		0x0004		/* synchronous memory sync */
> +#define MAP_POPULATE		0x010000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x020000	/* do not block on IO */
> +#define MAP_STACK		0x040000	/* give out an address that is best suited =
for process/thread stacks */
> +#define MAP_HUGETLB		0x080000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap u=
nderlying mapping */
> +
> +/* MAP_UNINITIALIZED not supported */
>
>   /*
>    * Flags for mlockall
> @@ -69,9 +52,16 @@
>    */
>   #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faul=
ted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_INVALIDATE	2		/* invalidate the caches */
> +#define MS_SYNC		4		/* synchronous memory sync */
> +
>   #define MADV_NORMAL	0		/* no further special treatment */
>   #define MADV_RANDOM	1		/* expect random page references */
> -#define MADV_SEQUENTIAL 2		/* expect sequential page references */
> +#define MADV_SEQUENTIAL	2		/* expect sequential page references */
>   #define MADV_WILLNEED	3		/* will need these pages */
>   #define MADV_DONTNEED	4		/* don't need these pages */
>
> @@ -81,16 +71,15 @@
>   #define MADV_DONTFORK	10		/* don't inherit across fork */
>   #define MADV_DOFORK	11		/* do inherit across fork */
>
> -#define MADV_MERGEABLE	 12		/* KSM may merge identical pages */
> +#define MADV_MERGEABLE   12		/* KSM may merge identical pages */
>   #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
> -#define MADV_HWPOISON	 100		/* poison a page for testing */
>
>   #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
> -#define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
> +#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>
> -#define MADV_DONTDUMP	16		/* Explicitly exclude from core dump,
> +#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>   					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>   #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>   #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -105,6 +94,9 @@
>
>   #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>   /* compatibility flags */
>   #define MAP_FILE	0
>
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/u=
api/asm/mman.h
> index 68c44f99bc93..80f4a55763a0 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -6,6 +6,8 @@
>   #define PROT_WRITE	0x2		/* page can be written */
>   #define PROT_EXEC	0x4		/* page can be executed */
>   #define PROT_SEM	0x8		/* page may be used for atomic ops */
> +/*			0x10		   reserved for arch-specific use */
> +/*			0x20		   reserved for arch-specific use */
>   #define PROT_NONE	0x0		/* page can not be accessed */
>   #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to s=
tart of growsdown vma */
>   #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end=
 of growsup vma */
> @@ -20,30 +22,42 @@
>   #define MAP_LOCKED	0x2000		/* pages are locked */
>   #define MAP_NORESERVE	0x4000		/* don't check for reservations */
>   #define MAP_GROWSDOWN	0x8000		/* stack-like segment */
> -#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x20000		/* do not block on IO */
> -#define MAP_STACK	0x40000		/* give out an address that is best suited f=
or process/thread stacks */
> -#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> -#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap u=
nderlying mapping */
> -#define MAP_UNINITIALIZED 0		/* uninitialized anonymous mmap */
>
> -#define MS_SYNC		1		/* synchronous memory sync */
> -#define MS_ASYNC	2		/* sync memory asynchronously */
> -#define MS_INVALIDATE	4		/* invalidate the caches */
> +#define MAP_POPULATE		0x010000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x020000	/* do not block on IO */
> +#define MAP_STACK		0x040000	/* give out an address that is best suited =
for process/thread stacks */
> +#define MAP_HUGETLB		0x080000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap u=
nderlying mapping */
> +
> +/* MAP_UNINITIALIZED not supported */
>
> +/*
> + * Flags for mlockall
> + */
>   #define MCL_CURRENT	1		/* lock all current mappings */
>   #define MCL_FUTURE	2		/* lock all future mappings */
>   #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>
> +/*
> + * Flags for mlock
> + */
>   #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faul=
ted in, do not prefault */
>
> -#define MADV_NORMAL     0               /* no further special treatment=
 */
> -#define MADV_RANDOM     1               /* expect random page reference=
s */
> -#define MADV_SEQUENTIAL 2               /* expect sequential page refer=
ences */
> -#define MADV_WILLNEED   3               /* will need these pages */
> -#define MADV_DONTNEED   4               /* don't need these pages */
> +/*
> + * Flags for msync
> + */
> +#define MS_SYNC		1		/* synchronous memory sync */
> +#define MS_ASYNC	2		/* sync memory asynchronously */
> +#define MS_INVALIDATE	4		/* invalidate the caches */
> +
> +#define MADV_NORMAL	0		/* no further special treatment */
> +#define MADV_RANDOM	1		/* expect random page references */
> +#define MADV_SEQUENTIAL	2		/* expect sequential page references */
> +#define MADV_WILLNEED	3		/* will need these pages */
> +#define MADV_DONTNEED	4		/* don't need these pages */
>
> -/* common/generic parameters */
> +/* common parameters: try to keep these consistent across architectures=
 */
>   #define MADV_FREE	8		/* free pages only if memory pressure */
>   #define MADV_REMOVE	9		/* remove these pages & resources */
>   #define MADV_DONTFORK	10		/* don't inherit across fork */
> @@ -53,11 +67,11 @@
>   #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
>
>   #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
> -#define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
> +#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>
>   #define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>   					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>   #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>   #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -72,7 +86,7 @@
>
>   #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> -#define MADV_HWPOISON     100		/* poison a page for testing */
> +#define MADV_HWPOISON	100		/* poison a page for testing */
>   #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
>
>   /* compatibility flags */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/u=
api/asm/mman.h
> index 1ff0c858544f..ad6bc56a7aef 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -15,57 +15,38 @@
>   #ifndef _XTENSA_MMAN_H
>   #define _XTENSA_MMAN_H
>
> -/*
> - * Protections are chosen from these bits, OR'd together.  The
> - * implementation does not necessarily support PROT_EXEC or PROT_WRITE
> - * without PROT_READ.  The only guarantees are that no writing will be
> - * allowed without PROT_WRITE and no access will be allowed for PROT_NO=
NE.
> - */
> -
> -#define PROT_NONE	0x0		/* page can not be accessed */
>   #define PROT_READ	0x1		/* page can be read */
>   #define PROT_WRITE	0x2		/* page can be written */
>   #define PROT_EXEC	0x4		/* page can be executed */
> -
> +/*			0x8		   reserved for arch-specific use */
>   #define PROT_SEM	0x10		/* page may be used for atomic ops */
> +/*			0x20		   reserved for arch-specific use */
> +#define PROT_NONE	0x0		/* page can not be accessed */
>   #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to s=
tart of growsdown vma */
> -#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end =
fo growsup vma */
> +#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end =
of growsup vma */
>
> -/*
> - * Flags for mmap
> - */
>   /* 0x01 - 0x03 are defined in linux/mman.h */
> -#define MAP_TYPE	0x00f		/* Mask for type of mapping */
> -#define MAP_FIXED	0x010		/* Interpret addr exactly */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
>
> -/* not used by linux, but here to make sure we don't clash with ABI def=
ines */
> -#define MAP_RENAME	0x020		/* Assign page to file */
> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */

If xtensa had those, those should be kept as well IMHO.

Looks good otherwise.

Helge

