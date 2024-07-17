Return-Path: <linux-arch+bounces-5458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80385933B8C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 12:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14DDB2243E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4E17F386;
	Wed, 17 Jul 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sSzQKesS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uj/+wQX0"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C717DE29;
	Wed, 17 Jul 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213711; cv=none; b=l0f7lL4PEITz4NtMVGmatwWyNwYGN7+h9PXGGKWJivjMdBehu8CyrFoZkT94iUMntVM+FkviOIonV+lOvz97LtybyQ2KRCAoEv4aJfHyrosNmxBIUsyAYRgq4tEZ12u8yXd+MtcwEapTzSChbhd7f6ZiNJvGzuqlQztg4C1Knsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213711; c=relaxed/simple;
	bh=AMsDz/Ku3aEvwfE1d5aax219Ew2wLx/1hyo1nCxhUyo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QbN1kmwT4dp6YckCVg6IpoQ3YSpynBXjONQQkB7XIjice5A3DR0Em6crSoA3IWPoWNSHu82dOMaKF+b7Cmt7pqyLJ5TT3PNyyt+HZlWZOAXCU+agDoEkp7oNobPQfJRLGcTHvdUKyHn7ytsPagYBiwXRIfcvKy8+jjZVmqWy3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sSzQKesS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uj/+wQX0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 547B71380286;
	Wed, 17 Jul 2024 06:55:08 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 06:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721213708; x=1721300108; bh=8TPRB3j9rL
	zE1rwWl+Ls1dJsZyiFWQAyaVNpYBWytB8=; b=sSzQKesS28tzRD3ycMfsHJZzHM
	mb+/LOuqTrCGwZJDGcQNnJdKH0Sj7JxGiyACbnSjdZ7jhKBEZhC26nSEXXff01YA
	3JpotsV7/zJ5MCe+fdyamsjsp9S2DrchwkfORG/ELfJ3aXGRzEWYCd3zDP9Bk8HS
	sGiiCkdFEOOq97/M6iqGdf4xbII/G8ccZWbljeSipuzObXbMUFC2VS/nqGduJ+kx
	y07wayoLPaub+/tRYZ8V7VPF80IFiCXx+01rWOqumEUBbAPnjdCNT9jh51VvokDA
	end0ch72kvrXPf2O/vnpUjMlgzNMfF+pA05NYI6k2P/CsDIDXTh+ilVpvT5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721213708; x=1721300108; bh=8TPRB3j9rLzE1rwWl+Ls1dJsZyiF
	WQAyaVNpYBWytB8=; b=Uj/+wQX06B0+FbPAETtoiXpL19N2SDw2r05omykUv9vm
	UQ5jN/5ooHFpKmC9/OeTLL/mryXkc+YdSCIbrqlgkbv3+XccswlTzizUh+8cP+IM
	HJCDQz9PpU692+Tl3nYX54rTTCZ9ds+kC6kEsmRFV3vV536xSEkjUAl+N8diE1i9
	noad3VfSoGRNuWozy1WyABALzTvES+8zWTHpl1+Hr4WXO+jNY6+EV3earT56nH+t
	iSweoq2QRsewPiFbHluLa+M2Ge+gJf7KYIK/nzoCoxpfyxyfefWwmpdxm6YoK1Pa
	7xVk1Bxni+/9WO5T8w/NDQyzIco11dk5HSvl10l6KQ==
X-ME-Sender: <xms:C6OXZuQOkBGuoTGdD5m5RKKuty_76kxEVrX373t3PNyieEnI7U3eUA>
    <xme:C6OXZjxL3aEmkVItid8N0JP73i5KAG3vPgc3CMf51q6jtRBrwlPslTjnkBmQB1zHG
    HVrJSgDm8_j4GRDSjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:C6OXZr1IgRed4C-ppieiHgf6s7NlVM1e-Ll20ASfZcKMAXmjw-RtvQ>
    <xmx:C6OXZqAyhWKbw21N6I3g1uwuLk08AmNjKjHvsb2gM7PZ0X_Wt--2aQ>
    <xmx:C6OXZngS9kXR_S5sGCT-6pUxi1CsSNHKGPU2wArBAcGIUJffhG0IrA>
    <xmx:C6OXZmpJ5HUuZfi2Eqz99SkyJK2dvK0bGYs7ddTni3cSWiNH7X1NCQ>
    <xmx:DKOXZsYyZp4SgPBafctwqljY71fPeEOjc5k00ZIdbHF5w7UykbObrQto>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EB13219C005E; Wed, 17 Jul 2024 06:55:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91b10591-1554-4860-8843-01c6cfd7de13@app.fastmail.com>
In-Reply-To: <4d471a38-f86f-429d-a1a3-b882439ef7ba@app.fastmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
 <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
 <ZpdnhhaQum_epcGp@hovoldconsulting.com>
 <be80d8f6-2a1b-4f63-a43e-652fa5328d11@app.fastmail.com>
 <Zpd-Bx3VwrYWVeTs@hovoldconsulting.com>
 <4d471a38-f86f-429d-a1a3-b882439ef7ba@app.fastmail.com>
Date: Wed, 17 Jul 2024 12:54:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Johan Hovold" <johan@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 11:36, Arnd Bergmann wrote:
> On Wed, Jul 17, 2024, at 10:17, Johan Hovold wrote:
>> On Wed, Jul 17, 2024 at 10:01:10AM +0200, Arnd Bergmann wrote:
>>
>> Yeah, that's not something I noticed at least (and I assume I would
>> have). And I only did aarch64 builds on a 6.9 x86_64 host (make 4.4.1).
>
> Ok, I can reproduce the problem now: I installed a Fedora
> VM guest and chroot mount and I see the same issue in there.
>
> My normal Debian host has make 4.3, so I'll see if I can figure
> if a specific change in make does it.

I see that there is a version check in scripts/Makefile.include
from commit 875ef1a57f32 ("kbuild: use .NOTINTERMEDIATE for
future GNU Make versions") that detects Fedora's make 4.4.1
as newer than 4.4, so for the first time enables this
logic that I did not see on Debian.

In my scripts/Makefile.asm-headers, I had copied the 'FORCE'
from the existing rules in arch/x86/entry/syscalls/Makefile
etc without fully understanding what that does.
It looks like this does not make a difference for make-4.3
but is actually wrong for make-4.4 on the generic rule.

This makes it work for me with both versions of make:

--- a/scripts/Makefile.asm-headers
+++ b/scripts/Makefile.asm-headers
@@ -77,14 +77,14 @@ all: $(generic-y) $(syscall-y)
 $(obj)/%.h: $(srctree)/$(generic)/%.h
        $(call cmd,wrap)
 
-$(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
+$(obj)/unistd_%.h: $(syscalltbl) $(syshdr)
        $(call if_changed,syshdr)
 
 $(obj)/unistd_compat_%.h: syscall_compat:=1
-$(obj)/unistd_compat_%.h: $(syscalltbl) $(syshdr) FORCE
+$(obj)/unistd_compat_%.h: $(syscalltbl) $(syshdr)
        $(call if_changed,syshdr)
 
-$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl) FORCE
+$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl)
        $(call if_changed,systbl)
 
 # Create output directory. Skip it if at least one old header exists

Masahiro, does that make sense to you? I assume you can
explain this properly, but I'll already send a patch with
this version.

       Arnd

