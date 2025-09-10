Return-Path: <linux-arch+bounces-13475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E707B5169A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B7C3BAAED
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4730EF72;
	Wed, 10 Sep 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pxUK7Ex4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Ky4gXRZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pxUK7Ex4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Ky4gXRZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF1288CA6
	for <linux-arch@vger.kernel.org>; Wed, 10 Sep 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506468; cv=none; b=mbd3Fv7Pv4jZJeQ8hL5IcJ+Q94y/kXSDCa0ihiDboSn2NkPMxt5fm851xn2DyaIAzLvaLUMfjgLay8YI2b5JRNP1vd0vMjZQo7t4G0X/CK4JDPxQzwnJaqrWxG92QZcz99QROxbfeYZE39UJrqeZaxnmqRFlzqh8merbPgpcv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506468; c=relaxed/simple;
	bh=EC7sFF7I2rLgk4E0lip3iu04YahpP6G6VRpjsv6Adoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ/MUwmtKLJTqwuLJsRTFOGdV5kkPcy4+WJxVWoPv3yBCnetPmyHr1I+NOar1Ui+G8P/EIVrhQsBOwdgAfHEsVxuHbRUPWOJgwULwkE/aJLprpXQplL+RJi6QaD9nO+HJTPrz0NL/5p58GeJvobCSlmKLKj4KOq3AZlSV4Eo80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pxUK7Ex4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Ky4gXRZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pxUK7Ex4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Ky4gXRZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4790221C86;
	Wed, 10 Sep 2025 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757506462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5gaLRnDjWbSxcnFQcn+mJTPFqz2bFPqndDkLtin1DQ=;
	b=pxUK7Ex4yGUYNZN5PAhw/Tv8WMvIaGVpDrwKkZypT8Tt/i7D8ZuxmpL/UcajxPIzwF7tEo
	7yqX/56rfaO8T8K4BA4kzZnZPmDrnda+0l6EoZmlxsQdE57FoTbaB1XrLnopGf2+mQL/Nh
	4zD0nijuHe6aMZY7DbzDYqXQEBWdGVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757506462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5gaLRnDjWbSxcnFQcn+mJTPFqz2bFPqndDkLtin1DQ=;
	b=9Ky4gXRZ131dmOszA0mfrMQRRdIB/H1HsExL07hjq7MUHDiFjy1R943NmRUPW9NaYMiMeh
	5Y3L9e/6vzRzwxBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pxUK7Ex4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Ky4gXRZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757506462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5gaLRnDjWbSxcnFQcn+mJTPFqz2bFPqndDkLtin1DQ=;
	b=pxUK7Ex4yGUYNZN5PAhw/Tv8WMvIaGVpDrwKkZypT8Tt/i7D8ZuxmpL/UcajxPIzwF7tEo
	7yqX/56rfaO8T8K4BA4kzZnZPmDrnda+0l6EoZmlxsQdE57FoTbaB1XrLnopGf2+mQL/Nh
	4zD0nijuHe6aMZY7DbzDYqXQEBWdGVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757506462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5gaLRnDjWbSxcnFQcn+mJTPFqz2bFPqndDkLtin1DQ=;
	b=9Ky4gXRZ131dmOszA0mfrMQRRdIB/H1HsExL07hjq7MUHDiFjy1R943NmRUPW9NaYMiMeh
	5Y3L9e/6vzRzwxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7870713310;
	Wed, 10 Sep 2025 12:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cE8GptrwWhadQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 12:14:19 +0000
Date: Wed, 10 Sep 2025 13:14:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com, 
	arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com, 
	dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org, 
	jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org, 
	liam.howlett@oracle.com, linyongting@bytedance.com, lorenzo.stoakes@oracle.com, 
	luto@kernel.org, markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, 
	neilb@suse.de, osalvador@suse.de, pcc@google.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 01/22] mm: Add msharefs filesystem
Message-ID: <do7cmy4eiiqd5ux62r3u2ghizc62ljg5m3mqx7qzy3im4kc2p6@upmigdbp7eat>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-2-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820010415.699353-2-anthony.yznaga@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4790221C86
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,googlemail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,gmail.com,arndb.de,alien8.de,kernel.org,google.com,lwn.net,linux.intel.com,redhat.com,arm.com,xmission.com,zytor.com,mailbox.org,oracle.com,bytedance.com,googlemail.com,suse.de,suse.com,linux.dev,infradead.org,goodmis.org,linutronix.de,suse.cz,linaro.org,zeniv.linux.org.uk,linux.alibaba.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Tue, Aug 19, 2025 at 06:03:54PM -0700, Anthony Yznaga wrote:
> From: Khalid Aziz <khalid@kernel.org>
> 
> Add a pseudo filesystem that contains files and page table sharing
> information that enables processes to share page table entries.
> This patch adds the basic filesystem that can be mounted, a
> CONFIG_MSHARE option to enable the feature, and documentation.
> 
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  Documentation/filesystems/index.rst    |  1 +
>  Documentation/filesystems/msharefs.rst | 96 +++++++++++++++++++++++++
>  include/uapi/linux/magic.h             |  1 +
>  mm/Kconfig                             | 11 +++
>  mm/Makefile                            |  4 ++
>  mm/mshare.c                            | 97 ++++++++++++++++++++++++++
>  6 files changed, 210 insertions(+)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 mm/mshare.c
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 11a599387266..dcd6605eb228 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -102,6 +102,7 @@ Documentation for filesystem implementations.
>     fuse-passthrough
>     inotify
>     isofs
> +   msharefs
>     nilfs2
>     nfs/index
>     ntfs3
> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
> new file mode 100644
> index 000000000000..3e5b7d531821
> --- /dev/null
> +++ b/Documentation/filesystems/msharefs.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================================
> +Msharefs - A filesystem to support shared page tables
> +=====================================================
> +
> +What is msharefs?
> +-----------------
> +
> +msharefs is a pseudo filesystem that allows multiple processes to
> +share page table entries for shared pages. To enable support for
> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
> +
> +msharefs is typically mounted like this::
> +
> +	mount -t msharefs none /sys/fs/mshare
> +
> +A file created on msharefs creates a new shared region where all
> +processes mapping that region will map it using shared page table
> +entries. Once the size of the region has been established via
> +ftruncate() or fallocate(), the region can be mapped into processes
> +and ioctls used to map and unmap objects within it. Note that an
> +msharefs file is a control file and accessing mapped objects within
> +a shared region through read or write of the file is not permitted.
> +

Welp. I really really don't like this API.
I assume this has been discussed previously, but why do we need a new
magical pseudofs mounted under some random /sys directory?

But, ok, assuming we're thinking about something hugetlbfs like, that's not too
bad, and programs already know how to use it.

> +How to use mshare
> +-----------------
> +
> +Here are the basic steps for using mshare:
> +
> +  1. Mount msharefs on /sys/fs/mshare::
> +
> +	mount -t msharefs msharefs /sys/fs/mshare
> +
> +  2. mshare regions have alignment and size requirements. Start
> +     address for the region must be aligned to an address boundary and
> +     be a multiple of fixed size. This alignment and size requirement
> +     can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
> +     which returns a number in text format. mshare regions must be
> +     aligned to this boundary and be a multiple of this size.
> +

I don't see why size and alignment needs to be taken into consideration by
userspace. You can simply establish a mapping and pad it out.

> +  3. For the process creating an mshare region:
> +
> +    a. Create a file on /sys/fs/mshare, for example::
> +
> +        fd = open("/sys/fs/mshare/shareme",
> +                        O_RDWR|O_CREAT|O_EXCL, 0600);

Ok, makes sense.

> +
> +    b. Establish the size of the region::
> +
> +        fallocate(fd, 0, 0, BUF_SIZE);
> +
> +      or::
> +
> +        ftruncate(fd, BUF_SIZE);
> +

Yep.

> +    c. Map some memory in the region::
> +
> +	struct mshare_create mcreate;
> +
> +	mcreate.region_offset = 0;
> +	mcreate.size = BUF_SIZE;
> +	mcreate.offset = 0;
> +	mcreate.prot = PROT_READ | PROT_WRITE;
> +	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
> +	mcreate.fd = -1;
> +
> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);

Why?? Do you want to map mappings in msharefs files, that can themselves be
mapped? Why do we need an ioctl here?

Really, this feature seems very overengineered. If you want to go the fs route,
doing a new pseudofs that's just like hugetlb, but without the hugepages, sounds
like a decent idea. Or enhancing tmpfs to actually support this kind of stuff.
Or properly doing a syscall that can try to attach the page-table-sharing
property to random VMAs.

But I'm wholly opposed to the idea of "mapping a file that itself has more
mappings, mappings which you establish using a magic filesystem and ioctls".

-- 
Pedro

