Return-Path: <linux-arch+bounces-1726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779983E133
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19451F25C23
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78820B27;
	Fri, 26 Jan 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WwTFXtg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqtbCBYT"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477691EF1E;
	Fri, 26 Jan 2024 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293352; cv=none; b=UKXayZ0rbx2JHuyy7DNwm2py+Zh02+d3jrnmgF6zQJAW+W9n9GSuu7TdV2oq0AoIhf+V010kv4cKQOcB7N5P4okv/KL3ABhSY8yU9w0+qFpiMmydL3ld6Dfhrd/XmBzigVOi4V9uZi2Ww3bL4UY1FOybOYc66qL7HZSwdY6BQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293352; c=relaxed/simple;
	bh=ISTav6gy5USamgpd2sC5q1Pn846nJZLvPr41KVdayiU=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=LWfh2lpCCkZwISYJmZwbIbp59f8wuN4EuXpIQ/3oKEwsYR79XXZHG4KKNxqHNMO1t59GLL661ISlPKPY4GwIqw+nQjoTyB84Ktzu67wNiqwMs9rhM3mSR9cnnOM5ilK9u+mWxwOJHg21FeNLYyzpmLlsWVCFHa/MeCcuvJjD2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WwTFXtg2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqtbCBYT; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id F186E3200B2B;
	Fri, 26 Jan 2024 13:22:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 13:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1706293348; x=1706379748; bh=baa2ePoCi53KJacePxC7m021mFpNN6sF
	Xm0uuhThUQk=; b=WwTFXtg2oktAwtf7R+OArO/18ScmaIor/VYzn1JB2+eiNfvi
	npvsphCQVJm89oX0PlmnPupMEHGTyQJJyvpfNrkzkwveYTM0W22zOfrK+9/ume0w
	0ZgZ0M14C/snXZ9uge5EyYtEPfzGcLs5zK+cmN8Qsuq1viWxcaDWb+IfcxDlK89p
	0OPeGBaF9vE+KJNt/3hE9liJ1AMKyNbfnZjPg1Acd1hI/5BUos1NY0x4K1+MwKqJ
	TpZVNTqAQC7tfKGFIBTzLmO6iS0ZZDGFA61M4QDx0v3TamrTE0td07i7IreXQZE9
	NYXtmKHmrSO1YfJuhvY24v8pkP7yEho969eSWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706293348; x=1706379748; bh=baa2ePoCi53KJacePxC7m021mFpNN6sFXm0
	uuhThUQk=; b=gqtbCBYTXSjSErPc1xrc5OCkzal2nmZGRCu8OFuqA8P7f67TbF7
	KCr+4Ln5VS9uUpIOjhF/ZggS/jarbYehrpLmEcFoYbSwOdC+czOhmtEKewfottSw
	J7DBz74emeRBROqWXHO84YifdL5aaxxUZjuKqrapoBTxBxLq5yyAc5eei0kcKm/l
	EwEUJWAHy2P0eOn81nYVob6iiST5x7IoeLpA5o4OD6QQVTL8kKj5ESttJO/jhm0p
	967cqjQ1Un2t36bXBmNLPUgfkYXHKCK4UqAWz0nzQA0T0g6bCx8XKdHtFXqXkgIW
	lASPU/RWKN9MfFkNFXo7u6Uh2HY7KPW+XtA==
X-ME-Sender: <xms:Y_izZdTbk4pVQPef861CNaK2xD5fl3Lkz2bqvKkwCGvm676b-OWo7w>
    <xme:Y_izZWwt258PG-v0GG-VxSkX770cEQM9WGUZgXGHlG8o4frwlOWnjG42ulcXiXbyH
    1MSdJBFZPySkQPOpsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeekieduheeitdfhfefgueelteettdelieetgeekteffkeeftdekkeelfedtvddu
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhoiihlrggsshdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:ZPizZS23EXp1V_UxNqhG5ztRvCyiFk-N8vb_bNTg-bZ0fClnrWymiQ>
    <xmx:ZPizZVDYfAyrQXgt9jM-w1csKvUGcZx1haRwHVaPWQcYc8786FP-Xw>
    <xmx:ZPizZWi-g4E8xjldVB-Xt-mQ9wRRUbqevj9V47uR2LNcxVdhMR7tzw>
    <xmx:ZPizZZswEV9CVUFgIH2jk-8A1cJPcJooIakdZDI7EfJskX2aOKorGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DE1C9B6008F; Fri, 26 Jan 2024 13:22:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9bd787f-7750-4277-8e85-783c9715ff96@app.fastmail.com>
Date: Fri, 26 Jan 2024 19:21:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [GIT PULL] asm-generic updates for 6.8, part 2
Content-Type: text/plain

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.8-2

for you to fetch changes up to 61f61c89fa5d9925e0b874854fb62e51948a6de1:

  MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc (2024-01-26 14:54:56 +0100)

----------------------------------------------------------------
asm-generic updates for 6.8, part 2

Just one patch this time, adding Andreas Larsson as co-maintainer
for arch/sparc. He is volunteering to help since David Miller
has become much less active over the past few years.

In turn, I'm helping Andreas get set up as a new maintainer,
starting with the entry in the MAINTAINERS file.

----------------------------------------------------------------
Andreas Larsson (1):
      MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..542ab762be7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20549,6 +20549,7 @@ F:	Documentation/translations/sp_SP/
 
 SPARC + UltraSPARC (sparc/sparc64)
 M:	"David S. Miller" <davem@davemloft.net>
+M:	Andreas Larsson <andreas@gaisler.com>
 L:	sparclinux@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.ozlabs.org/project/sparclinux/list/

