Return-Path: <linux-arch+bounces-7459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBD9874D4
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887E61C23280
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B95FEED;
	Thu, 26 Sep 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ed82I70M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3y/KsXa"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FD1C687;
	Thu, 26 Sep 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358885; cv=none; b=dn4lN0B/8an9QS4KqtF85mlnm1GxH0UtpJplkLsRbdy6OwLVlpVU7lqeBDwuIiOLK6gMrab3R8/NovXaxJim0Z5oHycFInl9r1TMBDO28AXldB6KYTj5bF1HIo18H2T8sWJxIbvzYKXooyohITigh9WJG8bXgK7L1lT8m5iItXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358885; c=relaxed/simple;
	bh=7eIAWn4HpDT6t3amyzW8vh7qQm7VIGks7ZlN9Zx8MHg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HzL4x71H+/f6YBvhydGkdEPzJnnGxm1UhE5mWe43U9LiN/rdB83HGHOHEPzP3B8X6ICrBFCuBpurlvAN7+I4kOwRZqJvOF8qAU9H/1tL1Cy9yYYN7RkvOQ00Ojbf+XiI+Wjryf0NXCxJVch0CDt8400PEmjqiCeXof9K8zlasnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ed82I70M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R3y/KsXa; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 152F51380297;
	Thu, 26 Sep 2024 09:54:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727358882;
	 x=1727445282; bh=6riDWHgJboduwD6LaSFNyFPLRcRPaab9kSUcfli2BKY=; b=
	Ed82I70M0gRdT9TOoYaLzrvfHoLQ2RkVw5BljDBCWBHW5/YtKj816v3sAP+b7ZSm
	cZoIFqIaVwq5PHBT/e35Wg4s5vbFREFevM//daefmaW6kP+XYxepPCYyTXHw3QZ0
	9Za1MYRn7T98NbA5SZfsbPsmZzSiI7SC3tSrSXiBBKVyfj2pBH6mBaNrjOxrFaHE
	j49q0/22DpSKg/bsY3mml7j9HF3n4sLnbkfP6PQILPBqWhYIc1DlKnqtFgxhz20J
	3kccxBEvmwm7gelOqzjUi/OyBkCJJShdYOKtnleaeWdN5njs6O1xbn4nIFM65Yhm
	YmauC2QVmPVGgRo9SrBwFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727358882; x=
	1727445282; bh=6riDWHgJboduwD6LaSFNyFPLRcRPaab9kSUcfli2BKY=; b=R
	3y/KsXabibaJ2Z/XkVysWRaZOs8MTtsGNxYTlNWKe7wzJP2qTTNiBsy3MdawjKzW
	0c/i8g4NVXfzSmdWt87jP66p8OWqjCS2WourGpBGTP2iwOVQgH79FH+EE3gQR0m0
	rheDEpOt7B7Dso+6iT/5xT59DHUYbAseI3FJ7vd9kVI6eGyd+dD6sxD56OuQ1Mgw
	4YU0P7chz9BoVPa9xYbZWK0T1egLvkjZunHNa98cjf8dNOsPcURxW/lkhDQYd9uT
	5YVDeZSGlPl3GmQQIK38QWLQjVwddi8BnzWgbhpeLRrZuKjZEtasvdnzWAy3mCM/
	WuF3u9Im8+31VwBTNF1PQ==
X-ME-Sender: <xms:oGf1ZkqdmIpA7o2_QzgaN1fdtEYURj_XJL8PbUipRTKbPtqfIWADNA>
    <xme:oGf1ZqqQeZTrmeBKpSvohuYmfbNnevz71Ar_g3IYdL_mHSretB_U6oJUuZO9-jznk
    16KkdMa_LQIOvQaVog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepgeehveefleethefhudfhjeeutedvtedttdejieff
    feeuieevhfehgeekieffgfeunecuffhomhgrihhnpehutghlihgstgdrohhrghdpuggvsg
    hirghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghn
    khgvnhdruggvpdhrtghpthhtohepvhhlrgguihhmihhrrdhmuhhriihinhesrghrmhdrtg
    homhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdr
    vghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoh
    eprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthht
    oheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgtphhtthhopehjtghmvhgskh
    gstgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhsthekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oGf1ZpOs0y-FbPti-OKl6xR1ZY2dhie4YLDkmurMdwnfxHpHtJYoFA>
    <xmx:oGf1Zr74k2DXoCSjpcxnYW6z-HhZzsyJVBY7ImllYBvWSFNv1qkDIA>
    <xmx:oGf1Zj5h518sYyyR-7X7t9gpI0zata-tw922AwVZ1WhK4IinxbpVLQ>
    <xmx:oGf1Zri38KCr4FELnXbIKGVGM8vn4Dn5Mz07V6elrrKyLhz_X1BznA>
    <xmx:omf1ZtSyM5YH_Y3K6L2LepXVBPOPk7t-GP7MIFO1kTmF_iVRLYo_xwlZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E77A02220071; Thu, 26 Sep 2024 09:54:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 13:54:09 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Hildenbrand" <david@redhat.com>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-mm@kvack.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>, "Helge Deller" <deller@gmx.de>,
 "Kees Cook" <kees@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Matt Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michal Hocko" <mhocko@suse.com>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vladimir Murzin" <vladimir.murzin@arm.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <1a1f118e-9a7c-4c66-b956-d21eb36fce48@app.fastmail.com>
In-Reply-To: <b7f7f849-00d1-49e5-8455-94eb9b45e273@redhat.com>
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-6-arnd@kernel.org>
 <b7f7f849-00d1-49e5-8455-94eb9b45e273@redhat.com>
Subject: Re: [PATCH 5/5] [RFC] mm: Remove MAP_UNINITIALIZED support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 26, 2024, at 08:46, David Hildenbrand wrote:
> On 25.09.24 23:06, Arnd Bergmann wrote:
>
> The first, uncontroversial step could indeed be to make 
> MAP_UNINITIALIZED a nop, but still leave the definitions in mman.h etc 
> around.
>
> This is the same we did with MAP_DENYWRITE. There might be some weird 
> user out there, and carelessly reusing the bit could result in trouble. 
> (people might argue that they are not using it with MAP_HUGETLB, so it 
> would work)
>
> Going forward and removing MAP_UNINITIALIZED is a bit more 
> controversial, but maybe there really isn't any other user around. 
> Software that is not getting recompiled cannot be really identified by 
> letting it rest in -next only.
>
> My take would be to leave MAP_UNINITIALIZED in the headers in some form 
> for documentation purposes.

I don't think there is much point in doing this in multiple
steps, either we want to break it at compile time or leave
it silently doing nothing. There is also very little
difference in practice because applications almost always
use sys/mman.h instead of linux/mman.h.

FWIW, the main user appears to be the uClibc and uclibc-ng
malloc() implementation for NOMMU targets:

https://git.uclibc.org/uClibc/commit/libc/stdlib/malloc/malloc.c?id=00673f93826bf1f

Both of these also define this constant itself as 0x4000000
for all architectures.

There are a few others that I could find with Debian codesearch:

https://sources.debian.org/src/monado/21.0.0+git2905.e26a272c1~dfsg1-2/src/external/tracy/client/tracy_rpmalloc.cpp/?hl=890#L889
https://sources.debian.org/src/systemtap/5.1-4/testsuite/systemtap.syscall/mmap.c/?hl=224#L224
https://sources.debian.org/src/fuzzel/1.11.1+ds-1/shm.c/?hl=488#L488
https://sources.debian.org/src/notcurses/3.0.7+dfsg.1-1/src/lib/fbuf.h/?hl=35#L35
https://sources.debian.org/src/lmms/1.2.2+dfsg1-6/src/3rdparty/rpmalloc/rpmalloc/rpmalloc/rpmalloc.c/?hl=1753#L1753

All of these will fall back to not passing MAP_UNINITIALIZED
if it's not defined, which is what happens on glibc and musl.

       Arnd

