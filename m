Return-Path: <linux-arch+bounces-4633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197088D5DCC
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C9B20FBA
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD685156F56;
	Fri, 31 May 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ryKsgfTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGmLKhE9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B687581D;
	Fri, 31 May 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146396; cv=none; b=gOzzaHufZkqbcrmkbwMqBbX2z18uo2uw4mr90LX0t1LfmcmteY9R6CM8Zf+eUWMIftrMENnwY/bhlKVH87AIBUdA+gwYiDc+AmzvqSV7uWdme8iKn20BsoWIAfLMc5fs5Pdb0ceVRnM+HWURU1Cr7vM6hZ7c35OpLzAbKysB+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146396; c=relaxed/simple;
	bh=h1Za1JuA+/HJcBG2jH9CuHIjJ+/KJJ3mh3YHwo4KnW4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=sVpDEB/mZzYEmKQJJEA/1OqEJiMsBnF2xQNqWhjPyuACYPdq+xXvpqnV25O/JrM4FGEV4M1SP05bjMbUNWLF6949ri0w6nxZPJicYNnq+c4Y5uLBOqcLcWVgu1SzOm8xtsbwp8YD0BZWAg36n2R+1s4/v+X9MBy+qkqx8fvYY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ryKsgfTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGmLKhE9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BB33B11400E2;
	Fri, 31 May 2024 05:06:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 31 May 2024 05:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1717146393;
	 x=1717232793; bh=/skB/qyAAv0jb3sZQDhAVmjEY4b0H5zQ0AWXbXSTWoM=; b=
	ryKsgfTkA01jdB1LMAm4X3WvoFCFddDHbVQL1CsiWZFUMj8ETJYcb+FcmRA8bVdH
	W80ELPYf5yx+VCIUkZfsrZbvfJY8fdN2zR6O4Sty0N0VuiQoH5yGwfJmXpcf+oe3
	3/32saBcikfG//sWRFPxaBF6vxguH6U546uh4BP7lj7nfWcysiM2wr7vFBeebWdd
	n/QnA5J0dlGeBY4L2O7R3jgkJZcH7M5wgsMDT/YSnaD9FysL/g1lFzaMu8GzUDBJ
	unqOso76vPVEuf114zpnJqex/hWGz4LO2c40aFPIdAES4YqEHBWBtGQElIraAiwm
	UGJ62z1YNOvTPXZ5XJCKow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717146393; x=
	1717232793; bh=/skB/qyAAv0jb3sZQDhAVmjEY4b0H5zQ0AWXbXSTWoM=; b=g
	GmLKhE9hvIClnb+x1Z4m251SEUdJuj4CBZBC9+tkYJiNp65Halik554oSaQcvVVM
	XlFSosc76KTXMmGC2iF7jI5P2rVlR9gX85x4ixV4Mrqt7XS7QFhglsP7c0dRukCJ
	KAZNecvuzGzypu1GzT4nA+ubiUv5zyRAhV65wBnR0iy8jNQWCLBS8Sd/e869BYB/
	/3ank/v86hZlz5r6ZrATcCCGxgdlXOCXkF5b2meSvOqaobrMGRq4E2RY2cKdN8EP
	5JCFTY+pOCwghbjugQnox5VXuzXJP94WVRTFRY4rMS6Vqlg4wWPD470l05xy2i2e
	lwhW9YdULEcyyYzWnb92A==
X-ME-Sender: <xms:GZNZZoGHXGimyLdnzgzlroANuuPyRUgiDI6h51KAeFIc1G13IgvJQw>
    <xme:GZNZZhW0BaLSKJSdrrNq1Ca2cY9Q-HY34mhjd86Y0zwujWgNmGonTyhZtW5IScf2q
    9EJd3dro1dWBLHbIgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffjeduieeuuddtiefgffejleeuudeukeffieejhfejueegueejudfgjeeu
    udehudenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GZNZZiLj9EyjlZ7d5b_tu1XwbTmlWtbX8Fxqkr7gpP-sWv3twAQdQA>
    <xmx:GZNZZqGtkOy6cO4g4rONLn7U-JjIzqlzjGQUO32tOysbm_23jlEDag>
    <xmx:GZNZZuVXSKC1fmMue65btQsPFSQEJ3QMcTMTuSjwWmeMZnvm_jIKig>
    <xmx:GZNZZtPGx1ui3IlPaevfvQr7pLylLV8a2RzdmQR1B2PtL1JfadbSig>
    <xmx:GZNZZsyI3aoP-0QCWLrdZFt6TqPn3CjoUyF3jgOJ3edgAuNChsM9qb1v>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B0ABB6008D; Fri, 31 May 2024 05:06:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2054e49-c465-46c6-a14d-b48949a738c5@app.fastmail.com>
In-Reply-To: 
 <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <20240506133544.2861555-2-masahiroy@kernel.org>
 <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
 <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com>
Date: Fri, 31 May 2024 11:05:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024, at 10:52, Masahiro Yamada wrote:
> On Tue, May 28, 2024 at 8:36=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:

>> I don't understand the nature of this warning, but I see
>> that your patch ended up dropping -fsanitize=3Dkernel-address
>> from the compiler flags because the lib/test_fortify/*.c files
>> don't match the $(is-kernel-object) rule. Adding back
>> -fsanitize=3Dkernel-address shuts up these warnings.
>
>
> In my understanding, fortify-string is independent of KASAN.
>
> I do not understand why -fsanitize=3Dkernel-address matters.

Right, this is something I've failed to understand as well
so far.

>> I've applied a local workaround in my randconfig tree
>>
>> diff --git a/lib/Makefile b/lib/Makefile
>> index ddcb76b294b5..d7b8fab64068 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -425,5 +425,7 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, =
$(TEST_FORTIFY_LOGS)) FORCE
>>
>>  # Fake dependency to trigger the fortify tests.
>>  ifeq ($(CONFIG_FORTIFY_SOURCE),y)
>> +ifndef CONFIG_KASAN
>>  $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
>> +endif
>>  endif
>>
>>
>> which I don't think we want upstream. Can you and Kees come
>> up with a proper fix instead?
>
> I set CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_KASAN=3Dy,
> but I did not observe such warnings.
> Is this arch or compiler-specific?
>
>
> Could you provide me with the steps to reproduce it?

This is a randconfig .config file that shows it, but
I've seen it in a lot of others:
https://pastebin.com/raw/ESVzUeth

If this doesn't reproduce it for you, I can try to narrow
it down further.

     Arnd

