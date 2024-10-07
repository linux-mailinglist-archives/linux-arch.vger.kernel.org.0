Return-Path: <linux-arch+bounces-7749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E49927BA
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3781F2307E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11827165F08;
	Mon,  7 Oct 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SBSztwnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q37LPfrP"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E1FC0C;
	Mon,  7 Oct 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291709; cv=none; b=IT5tqZRF8w4VnRTpHxvTQbM6xUVXdnC8g7XBQZOJ3/EdC/1celMio87slJvNOBmuj4DJMEluh83B1GqZzeO0a0kRxtyNN6c132Egf58qqb53Y0j8hIDueAZxj4zV0yNQcBF+dw8wnCCIFJHyObZ9akp/FyTwEDKqZ4MiMrdCDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291709; c=relaxed/simple;
	bh=lIvANdxQwZyDZdLUVNCti4Lij9BIA3+ZJyP22MJcY6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU6z+SqG8lhmbMwAPKBuPlVGD+D3xaoR2+THPHJePfhu2y7kpAnL7FS0ElSoOgZWsoaGv5N+KmkBkXu44pZlfvHAjG4xYmdpsDHjBVK8UDByagDLf9d2PfeEe6gnEimDiIA5SqvRQ//rr8bD98jCJth+oHSTvr3R5NG95DuA+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SBSztwnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q37LPfrP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CF9913802C0;
	Mon,  7 Oct 2024 05:01:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 05:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1728291705; x=
	1728378105; bh=uStRBbXfvM44DoheU5xFLvdvQrOu2JgnSkwGD34tKSo=; b=S
	BSztwnf3R1DrhYkKMNssz8jnKT+nAA9kVfgT0BCITOnfxe6XkCnKivxyeSi7iAXC
	T/dbtvTAgkvQ8pz4elX+8zVSgrdYcxtjMKEVLk/dRAB1NcmP7Gpu0NDSPcRWjJvg
	7N9ppT7T/hxOE4m+18jvdr4QCo+2+SV7M2n48w4mqWh3EzXXDO/nu5ZlL11t7J5i
	VGQySeDcnvvy5rbRthdBI1csHOnX4oBWoic/60cQBfNPiDBdhZM1b7w2FaRVtO/r
	KUk2RonZW35PymNeMe+1l6QP2l2ZMsNKz4Y3a6fIjtkGTdwqpUpgpROHvrNAvR0V
	p6YFAeK6leu/Ta9XXyjkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728291705; x=1728378105; bh=uStRBbXfvM44DoheU5xFLvdvQrOu
	2JgnSkwGD34tKSo=; b=Q37LPfrP/ZyeI7MEWjBR1qqzLXMJm8OKA/f09vax55Ja
	fCLQdcuhdu+ynqo3EFOtdxwKGwGa331S3EbPG5BCRZDa6DdoLYRTWeRkiJUMvAzm
	KUofgmksUHgaRoY2BmmMG46VViumLQQs11l2SVXU/9Y+DafiiZLo7uNtQZw5QxcI
	+9ekMoy6j/9mbTY4NBXD4mmVi7Px/7rl2tIw7i6rhmZrtxgiKf0CU3u1JLaDXeA9
	m1H2wtS2LY5psDsI8rs1tv7Xytu3BatVk8ST9gMWd17tQ1V1e3x6f4c98X7uP212
	XXEemQ0WP7BfbJ9dS+4VKpmrepJjC5qjLgWXwv+jzQ==
X-ME-Sender: <xms:d6MDZx9fpO1j-u_Qo3VmNf7F3rp58UOvx_mmX0XffSXFqsj6PHTF9Q>
    <xme:d6MDZ1t2_Lamov2Kw8AY814xiRPLAbspadTEzzjAEzzli6Y6FUceCf_8TUGQ5wnHi
    oeuVzHvPy8Uoq_S_3A>
X-ME-Received: <xmr:d6MDZ_B-GLngvBLKCmZmylp9LXkhiJc375pzF8oM5b6479QPFhK5gZEth2w1VqygD_DPyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhhthhhonhihrdihiihnrghgrgesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhhkhhgvmhhm
    sehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlh
    hinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepkhhhrghlihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvhihknhhvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:d6MDZ1cYnTuL0UdcjH97FtCXaoWD2HfWg8V3HkLVB6_5KPtNFPkiVQ>
    <xmx:d6MDZ2NLOaRjg4wiCRzTC6b2iqsz50gWjb6NJZi6EsMdwGi62vv8Hg>
    <xmx:d6MDZ3mnSkDFsnZmkmJkjXe0opYaDFRyGDNygulXiBuBXK0vHgi9mg>
    <xmx:d6MDZwuWaTZskVwPPZ0xSZqz7Yxl_LcJ9Qw9i4p9jdUZxjt3DlBpeA>
    <xmx:eaMDZxeZWVvReVlX_GtumzeezkEa4tsNJmnCGXHlKyS3UBo1UZz6OlyC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:01:36 -0400 (EDT)
Date: Mon, 7 Oct 2024 12:01:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org, 
	arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhiramat@kernel.org, rostedt@goodmis.org, vasily.averin@linux.dev, 
	xhao@linux.alibaba.com, pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
Message-ID: <nst3wauaphvvnkseuatqknxfhtu5ewf7zqmoskim5kt52wf2mi@sasls2f6r22i>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903232241.43995-1-anthony.yznaga@oracle.com>

On Tue, Sep 03, 2024 at 04:22:31PM -0700, Anthony Yznaga wrote:
> This patch series implements a mechanism that allows userspace
> processes to opt into sharing PTEs. It adds a new in-memory
> filesystem - msharefs. A file created on msharefs represents a
> shared region where all processes mapping that region will map
> objects within it with shared PTEs. When the file is created,
> a new host mm struct is created to hold the shared page tables
> and vmas for objects later mapped into the shared region. This
> host mm struct is associated with the file and not with a task.

Taskless mm_struct can be problematic. Like, we don't have access to it's
counters because it is not represented in /proc. For instance, there's no
way to check its smaps.

Also, I *think* it is immune to oom-killer because oom-killer looks for a
victim task, not mm.
I hope it is not an intended feature :P

> When a process mmap's the shared region, a vm flag VM_SHARED_PT
> is added to the vma. On page fault the vma is checked for the
> presence of the VM_SHARED_PT flag.

I think it is wrong approach.

Instead of spaying VM_SHARED_PT checks across core-mm, we need to add a
generic hooks that can be used by mshare and hugetlb. And remove
is_vm_hugetlb_page() check from core-mm along the way.

BTW, is_vm_hugetlb_page() callsites seem to be the indicator to check if
mshare has to do something differently there. I feel you miss a lot of
such cases.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

