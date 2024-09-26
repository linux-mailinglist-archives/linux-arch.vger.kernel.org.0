Return-Path: <linux-arch+bounces-7457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA4987078
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B29E1F2924E
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBEA1AB6D0;
	Thu, 26 Sep 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m5CWey+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHE1jY+h"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652941D5AB0;
	Thu, 26 Sep 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343734; cv=none; b=S6ukqdqrtBUTp73cffluvcHlXAaf7b1QCz7vlXAG7tSZkk8EyaAmyD/LhFX327gredvMZoK//SBf8ZBxTry3fKvvyivZwrxuLDGeZ+8rPQX9u5flZ46Aqt0dGbt0rOogfczFXmRvEw/lFrs9CjWuza2xF3ttUadGY/ssN3KRcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343734; c=relaxed/simple;
	bh=nBrTsd6U6ryig1qB0in/czytk47gYLOayKDOMxrwbBo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J44JCrr3h5vyVoBS8PN+r2/8erWv+21hfG3P5OzLCxdKrcIiJhT3xQ7DCNwQu6/ph5szR0eVly9NlcfDGk1OP3tCUj7fA17bOYTm2TE0jFB36f2f5eO1DdFtzLve+xMoStUogltCc8yWw+HPIDdGPZ308LLli/TkhWaaC7OC4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m5CWey+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHE1jY+h; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DB5811401E9;
	Thu, 26 Sep 2024 05:42:11 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 05:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727343731;
	 x=1727430131; bh=Iz/f4ZHWxcDHUsU3hchNxxVI0CA6JwJ/25nEB88OEYc=; b=
	m5CWey+73vWL67jCVJR3EmjZDDiNiCw6MO+Ot1XUWYv5UfyjS8s3pN8TAbLQff25
	Sg6lrqUj15QUnRMNC9xx+OWfhvgvgrksQWBj9T71HyGavK79/2CaQa0kUPqTh7DC
	Fvt6VTvqyu15O2wq2P1yNKc9kYs1KYLNWqvusXnHo+loaICAWCuREXIa0dAhwayW
	dzUsDVdiFBIkIpUPDYOS+MBbIfIgIpzznF12mOowuL5GFdjCASs+wKfoomMiWhwN
	5YOjy90Pt4UmI8r1l6CNvouZkNU3ehNp/5NfSx7fSEgs+Nxpdha1xWTGdlfviajT
	usv+4HhF6PYFGOYEoLiD5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727343731; x=
	1727430131; bh=Iz/f4ZHWxcDHUsU3hchNxxVI0CA6JwJ/25nEB88OEYc=; b=I
	HE1jY+hK5ssV7obuCeyf3Vdk60sSKieOqkFdb5lrwkWZHYABR3YVlRs6krmSEFhR
	q4sSUNNhZbsHn6M2VmRhDf3Z5+MPJKHd8mkW26jIvRkhlwzFTTY1jlGq2olCFpoK
	aWSBwihRg70fnc1s9rjayXphF2frGbXouJWg09xfG7mEc+Kdy8K1gHZyo+ZSTt5r
	e86m+2uanNC+DEvI+o3C3DXeF84aBM79rZ4i/0Fy/t+h3XW/Hv6bhrdLmj7F1BTU
	oewFEEcmhImsDH8zdXehWqQCIFsGSoo53UAFQiHEJkZykxgQK5fdC4c48kS6PUzp
	LswjblX5lMItVKprSRK1Q==
X-ME-Sender: <xms:cSz1Zhtw1sfZrN0_xZrFwtJRo2ly2-IIkoRYRf9XSecslFFW1Yf4Tw>
    <xme:cSz1ZqcZ4Mn_-B479ffF-LvgWpgZ28YanTE9yczZDJSgIjZuifQSHXPL-CQJDm_Ml
    BRD_QTArWMmc59cnzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtohepvhhlrgguihhmihhrrdhmuhhriihinhes
    rghrmhdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsgh
    hrohhuphdrvghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhr
    tghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpd
    hrtghpthhtoheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgtphhtthhopehj
    tghmvhgskhgstgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhsthekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cSz1ZkxOy7rSDphLVTS9LNfuz-xZ0DcXkD6LyC43AmZN667_3xHB2A>
    <xmx:cSz1ZoMK3Ivf8CmyIKLE6hKsYKr-YNbjQG7uuStVPR-pjZccy0tKbQ>
    <xmx:cSz1Zh_wKcXgopX3k4tdeJ6efe46wxmqzIDVda7tQ8Fy8BZtjp_XKA>
    <xmx:cSz1ZoWzEWCkfV0KRcfMRcpDM2Bi9GmS53CNCbQ-fY7gzvdDbHuemw>
    <xmx:cyz1Zi1TkI4jfNUeOagyzusT7o8TNSwRW2Vz9A5SbAkc5TgSR8JAE3m1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 333EE2220071; Thu, 26 Sep 2024 05:42:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 09:41:48 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
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
 "David Hildenbrand" <david@redhat.com>,
 "Greg Ungerer" <gerg@linux-m68k.org>, "Kees Cook" <kees@kernel.org>,
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
Message-Id: <a44eb23a-97cf-4920-8cee-5197754d28f6@app.fastmail.com>
In-Reply-To: <b27eb97b-cb76-4fa8-8b8a-66d3bec655ae@gmx.de>
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-2-arnd@kernel.org>
 <b27eb97b-cb76-4fa8-8b8a-66d3bec655ae@gmx.de>
Subject: Re: [PATCH 1/5] asm-generic: cosmetic updates to uapi/asm/mman.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 26, 2024, at 09:21, Helge Deller wrote:
> On 9/25/24 23:06, Arnd Bergmann wrote:

>> -/* not used by linux, but here to make sure we don't clash with OSF/1 defines */
>> -#define _MAP_HASSEMAPHORE 0x0200
>> -#define _MAP_INHERIT	0x0400
>> -#define _MAP_UNALIGNED	0x0800
>
> I suggest to keep ^^ those. It's useful information which isn't
> easily visible otherwise.

Fair enough. I removed them in order to bring the differences
between files to an absolute minimum, but since at the end
of the series the files only contain the map values, there is
no real harm in keeping them, and they may help.

>> -/* not used by linux, but here to make sure we don't clash with ABI defines */
>> -#define MAP_RENAME	0x020		/* Assign page to file */
>> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
>> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
>> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
>
> same here. I think they should be preserved.

Right.

>>   /* 0x01 - 0x03 are defined in linux/mman.h */
>> -#define MAP_TYPE	0x00f		/* Mask for type of mapping */
>> -#define MAP_FIXED	0x010		/* Interpret addr exactly */
>> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
>> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
>>
>> -/* not used by linux, but here to make sure we don't clash with ABI defines */
>> -#define MAP_RENAME	0x020		/* Assign page to file */
>> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
>> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
>> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
>
> If xtensa had those, those should be kept as well IMHO.

The thing with xtensa is that the file was blindly copied from
mips, so I'm sure it never had these, but there may be value
in keeping the two files in sync anyway. The only difference
at the moment is MAP_UNINITIALIZED, which is potentially
used on xtensa-nommu.

Let's see if Max Filippov has an opinion on this, otherwise I'd
keep it the same as mips.

      Arnd

