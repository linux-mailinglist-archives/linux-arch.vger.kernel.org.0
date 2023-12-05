Return-Path: <linux-arch+bounces-694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EE8057AA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FFF2825DF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34F5E0D3;
	Tue,  5 Dec 2023 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="u1IX5t1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcbZZZvk"
X-Original-To: linux-arch@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B671BE;
	Tue,  5 Dec 2023 06:44:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 442705809BA;
	Tue,  5 Dec 2023 09:43:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 09:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701787439; x=1701794639; bh=BS
	Hv0HRg2s93B8FPGN2syxnLQruwc1c3RDbBmnf0NEA=; b=u1IX5t1rodixlie6Mp
	rRUGBkq+57oNX93kpP2WS0tc+JxK4MUExGO2BGRuFejA6BmZqnSeaTZiRIxRStDL
	PQkXiXRkw9/hqC390WBM1S7CAdB4ZeuRU3fCqjtLTsAzg0iBX74PNC9gWve7FDcT
	66Sxd5Ux/KhUHR2sJxHlUdfImBvKyrF1ZoNHQH8Ist/eIHOWwVxqHRD0QDhH9OgY
	ui1N18qdxTUktEgpWUHksybaxQwrY/oUHRWVZAobZzqMzb2sqZaA2pT+SuyK2mSg
	d3OVMe+wvWkw9pbnjOPUkws4CeWlZ4kICoKVv29QlJ4H9UZvFrq3ECN/JBDhQTRK
	umxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701787439; x=1701794639; bh=BSHv0HRg2s93B
	8FPGN2syxnLQruwc1c3RDbBmnf0NEA=; b=FcbZZZvkeXMfqqU2ugxqiRbdUcPJ5
	ymo1akoaXYdzDU7GzGTPnxzpiOwGl1wu0hJn3v0TqLY7lnrLXpWf8QMm0jsxivaj
	gBJ3SV+YQz+K9y7x+StZJUm16xqa+k+WorwzZB3lHp3AmYm9bh/IxV1JT5ByY7i9
	7sF8GdI5s+08I881coqR/RCg28ZLyeWQWjGLeEWqUIbbYcbEIGm2wFDTNltjQ6pO
	eRwc6Tzva5UXZ5WVl5FDzUBd0pn4qK8hKXfjmqC9DpQHRh/gzz/LrX0IJo4xnxLc
	fbSd44UIKgcoYIMwTBr+YpQ4732fj6MYbgUKgJ3Q+ZYU6x0nTnoQqsILQ==
X-ME-Sender: <xms:LTdvZcvpIl9nji2P3RiYHhphpt4DMzJCaVK7AM6KPg_fib2z3zkSjw>
    <xme:LTdvZZcJBLnEh0eNjavNkg8VpxX6P5xZMCA-cNlYioqXWr8EL-riDvKk3ORlRLH0M
    n8g_wVvZ7eDYd9ZxCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LTdvZXwX6ic-mqqBUJj0sx9IOyb_C9LkwN7Rju0hMc-z8fVrcaHYvA>
    <xmx:LTdvZfPT-MJD9NhJI2meGxhrspJheC3U1AuuYVZRyKx6Xy4U6vP6Zg>
    <xmx:LTdvZc9Upuw5ikljwzjowtCfY3LyBnMiIgy8KK43C7jSDCcwCh7QiQ>
    <xmx:LzdvZWFPSNTis7SBLJWDFNa-ISdel0cTumosQ1q3sWkadBr4KCpGGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 66E5AB60089; Tue,  5 Dec 2023 09:43:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cdb1188d-7379-45e2-b2ce-ffdfb21b644a@app.fastmail.com>
In-Reply-To: <8ec1ae92206c090c79a9ab9586bd17349798b08f.camel@redhat.com>
References: <20231204123834.29247-6-pstanner@redhat.com>
 <202312051813.09WbvusW-lkp@intel.com>
 <8ec1ae92206c090c79a9ab9586bd17349798b08f.camel@redhat.com>
Date: Tue, 05 Dec 2023 15:43:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "kernel test robot" <lkp@intel.com>, "Bjorn Helgaas" <helgaas@kernel.org>,
 "Hanjun Guo" <guohanjun@huawei.com>, "Neil Brown" <neilb@suse.de>,
 "Kent Overstreet" <kmo@daterainc.com>, "Jakub Kicinski" <kuba@kernel.org>,
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
Cc: oe-kbuild-all@lists.linux.dev,
 "Linux Memory Management List" <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain

On Tue, Dec 5, 2023, at 15:34, Philipp Stanner wrote:
> Alright, so it seems that not all architectures provide ioport_unmap().
> So I'll provide yet another preprocessor guard in v4. Wohooo, we love
> them...

Right, I think CONFIG_HAS_IOPORT_MAP is the symbol you
need to check here. There are a few targets that have inb/outb
but can't map them to __iomem pointers for some reason, 
as well as more that have neither CONFIG_HAS_IOPORT nor
CONFIG_HAS_IOPORT_MAP.

     Arnd

