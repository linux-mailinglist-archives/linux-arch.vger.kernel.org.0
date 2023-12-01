Return-Path: <linux-arch+bounces-598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3FB800D98
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BFA281BCE
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78912BB11;
	Fri,  1 Dec 2023 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uYcRRnt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0dayboYg"
X-Original-To: linux-arch@vger.kernel.org
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 06:45:07 PST
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D110F9;
	Fri,  1 Dec 2023 06:45:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id C97045809F7;
	Fri,  1 Dec 2023 09:45:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 09:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701441906; x=1701449106; bh=+L
	CHDVdMO4HroZLW4+K9iEctf8j8Pnc97pjq2+19EyM=; b=uYcRRnt0ypzG+T8STd
	NQrTedJ4t8y0QKNJgAZMqlWY3f00cPTsTaIXTxIpFmqq7hJEECpNU0LqRb6bcxlC
	ObOEogFq/gXRXJPgdKt0uj978H4ktMy5QTAt4c8wGeVqnhSuJivsbNTAIc8vNG/0
	kGqnfX6AfiroCZw8elB/ZcBja7NHtMgBcZfdf0F+4O4M92fPynweAgK8BZ/Uezv4
	HuSUTBed+UAbjBq6YyG5ssvoIVr4TwyowCUetCQAXxRDntTIfeQ7m9hINLuSdEw4
	Kt0W9XQvzynA2ian5d/Skxr5U+OD5fbfp7LPznSkAtB4T8KSfetaJA6jJLuREucL
	zvnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701441906; x=1701449106; bh=+LCHDVdMO4Hro
	ZLW4+K9iEctf8j8Pnc97pjq2+19EyM=; b=0dayboYg4YVfLSp9hNyPyWJXns73T
	SRa8QuDwE+c8lIYmC5/t3uefRAnTr9hujOPoNi9/SVoT0qP3n/x08EnjZwL8q9Ua
	kP71YcKmgAeCbOuciaGct6Q9fiXCExG08YTzovOK18X1SjtZNJP1LnDnhEXAK7ds
	/fZdLVtXPaUYactCyaLG+Hqf8CICJjWNcv8YYlcCDSxBjr2LGWJD6DTyzsSn+Td2
	Nnf0nd6JaBnS+/SU8qqflw0PnS+pbFjedMbBUtmf3VvUGbVKw01fQePx7hcbLrRZ
	p7nCNEPutvSXFhbea2eJ0bTlCCjqj6MGPsPTCiSMsdwfKuNYYLbEvSZrw==
X-ME-Sender: <xms:cfFpZQ1CG5NdFTXZ68XBLazYcvfypIXc78eUEdp6YJDoySA7pNsCjw>
    <xme:cfFpZbHp5JFCiZIwVHAwnfLNwRdyxO2XwSUpm82KIoo7LKDYNARJJ4wG5HzW5ZzjV
    wpE7aGaNQyIV5IfJe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cfFpZY7e-KyiayVgkJpo-i1ayoVGmJz_zybGKW6FiLkOtKLrOt1miw>
    <xmx:cfFpZZ3CtdGZPa6sBS2cq4_eTsTr6pdO4JtYHsQMqHMFCstNd44dPw>
    <xmx:cfFpZTGvPGLr9As6kKvuuoBgumiPsnibN1HkdvSr8qpriD0ftGd7Vw>
    <xmx:cvFpZbOqIU7ip9gmR0yiazV2Zf4CI2KsorVZuIknhVpONDGKfxOCwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 80EE6B60089; Fri,  1 Dec 2023 09:45:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
In-Reply-To: <20231201121622.16343-3-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-3-pstanner@redhat.com>
Date: Fri, 01 Dec 2023 15:44:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>, "Neil Brown" <neilb@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "John Sanpe" <sanpeqf@gmail.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] lib: move pci-specific devres code to drivers/pci/
Content-Type: text/plain

On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> CONFIG_PCI and, thus, don't belong to this file. They are only ever used
> for pci and are not generic infrastructure.
>
> Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c.
> Adjust the Makefile.
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/Makefile |   2 +-
>  drivers/pci/devres.c | 207 ++++++++++++++++++++++++++++++++++++++++++
>  lib/devres.c         | 208 +------------------------------------------

I still think this should go into drivers/pci/pci_iomap.c along
with the other functions.

     Arnd

