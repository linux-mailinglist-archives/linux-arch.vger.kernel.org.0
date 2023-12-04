Return-Path: <linux-arch+bounces-635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F05F803515
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B3BB209D8
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B325102;
	Mon,  4 Dec 2023 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cgiypl4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stj+BqHc"
X-Original-To: linux-arch@vger.kernel.org
X-Greylist: delayed 104 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 05:38:02 PST
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680CB2;
	Mon,  4 Dec 2023 05:38:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 5EC605809C8;
	Mon,  4 Dec 2023 08:38:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 08:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701697081; x=1701704281; bh=gu
	842SvCxM10CbBvjGGfXJsdDRM+ooxinHUyG93c9tM=; b=Cgiypl4L3d/VkkXaIb
	0z+ZBP4uKrtoQJ0WdttPRebjgssJBJmG1xo/53dGJ/c2gAqAbj7LE3IZKwL+6lAD
	wegXMIVwkvbmmgV+rQ8qiHcOpMuCyqd9ojgMuUQ66RCjEVMR5kIusZpYoM3xuJPg
	F+CmN6INnwo19tTYg3YKuoTvFo9rRIoG3HR2+kAtYwmV1w2kET9BT2Q5z4Z7qj8V
	uzunLN9USsPmqfkVTsu3ll2QpGG/yZyqzYAPwreQt6xZOJfe5dUR0XX/ujprdcIi
	B97VRBOafQLRiee1sWz9xDnxo7Evj7JU6PKHLyT8u1oDdtiE4pJdDBySZucg6jiu
	MaKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701697081; x=1701704281; bh=gu842SvCxM10C
	bBvjGGfXJsdDRM+ooxinHUyG93c9tM=; b=stj+BqHcw6AZozZiDBSlZjiqJmpHV
	K8ejaSOwjVWAKsMhOmyEqXl5tVZxPaNpzGqPlj6AbOPZkzL2q2Yv+WTTWXq5tFOz
	EqAcDVi6Wruu4eBUK8zdaJQMh3E/ZjNhOtfnmFLCqVdw4G4cyolw6BnBH516Tv8B
	xtos9wJPIza7VB9LV7r5AOGC9RcJjpLfnqY3OpeNgNPBcb1GbLFFcqgI87VK0ZVg
	kp2GX7/ytuQr1TwHnWN+LQ90LsoSP2A/x+nj95six5dDVCCD7sU5OA7dY3QDcO5b
	Qcln6D+UTQthHdqmo2hujdtXIVQ6Mu9t1EbFhFsesfIZfasrizoV2svLw==
X-ME-Sender: <xms:OdZtZYzMG6GvJFDIlB0HSjjUONwPNZyLrMgKOLwGLLLiDLpNHcv49A>
    <xme:OdZtZcT7odOkvR8tRzBz7MooeWkNBzNR0Mg4I-KHQWsn-zles928mVDCyGWGjngqT
    mZN8xZALs_hA3q8_Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OdZtZaWiOqzI1NZ1YozuQUScTtBWb6AY-UGT273rxAtysK9nmVbtdA>
    <xmx:OdZtZWjqFk4Fy1WiyjaHH5dCzwOg9CdsmqwJ10LEOugDAIi4uwG84w>
    <xmx:OdZtZaACf1pjxOFrHu6pMh3IdlXbuzJfswe6mD3yebTbYbbF96s6rQ>
    <xmx:OdZtZcwcjrxeM4CY1moE4xfF9Wflkk1qiOzg1I3OQDV9sEtnkMhrRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1565EB60089; Mon,  4 Dec 2023 08:38:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <652e62ba-5e23-4672-875a-8b5a3a8cb494@app.fastmail.com>
In-Reply-To: <20231204123834.29247-3-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
 <20231204123834.29247-3-pstanner@redhat.com>
Date: Mon, 04 Dec 2023 14:37:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Hanjun Guo" <guohanjun@huawei.com>,
 "Neil Brown" <neilb@suse.de>, "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>,
 "John Sanpe" <sanpeqf@gmail.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] lib: move pci_iomap.c to drivers/pci/
Content-Type: text/plain

On Mon, Dec 4, 2023, at 13:38, Philipp Stanner wrote:
> This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
> belong to lib/ because it is not generic infrastructure.
>
> Move the file to drivers/pci/ and implement the necessary changes to
> Makefiles and Kconfigs.
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

