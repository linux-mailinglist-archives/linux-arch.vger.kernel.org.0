Return-Path: <linux-arch+bounces-599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A4800DC4
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A63F1C203BB
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F733E467;
	Fri,  1 Dec 2023 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="M8oHNdH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvF3JFrw"
X-Original-To: linux-arch@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727BBD;
	Fri,  1 Dec 2023 06:55:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 6FA835808AE;
	Fri,  1 Dec 2023 09:43:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 09:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701441837; x=1701449037; bh=kK
	o4dJKblO+HlaEynT7R0ipo9rNcBzF1TALtacSN8BE=; b=M8oHNdH+cvykmc/+5J
	8RMXWyg22pwYkaY44RoX9SPAkdK1aLBFwwkj4sptf+YpDIdDWuTHixMt9aEH++tj
	kRSLFukS+/iWZDl3Q0aoNgsvZ8NUjDBSh39eGILjEePgB5J6m3aLFYpHYIztcwMU
	jKm81uFGfDBlzWrPt5/0p7DrQTiGlFdjyBx76kxrq+8KsEBvUgXzyCBFFzMl0fNL
	i8wvSsEhMh2XHOhbJ08aVytYJYkjEYgxtRGwAR+RCpNkU4rOpaDvol39QD0QGJDx
	U3QPyA+VAYxSUKSbtQrHD//p9vvDd8gZi+BgknFw5FSC0jNXuHmv9Jf9vMz90S3w
	sPuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701441837; x=1701449037; bh=kKo4dJKblO+Hl
	aEynT7R0ipo9rNcBzF1TALtacSN8BE=; b=gvF3JFrwR29gFH3qJWYjCOqt3lyop
	MwdkBKVOAx3QaD9AsJ+mKQvXRb+g3ZVqwY8+x4NjTbHwwvcebV9LRkL7NEtTJvfE
	3oBykOvMihi81cveRMT/4Uk8DBrNnKptFYiNvuF75XpUEv4CgHRDUFgaBehOJkOI
	HKPkil0zv46wXWPldhcOqaBYlgC4878tbGVMBU3DNpqk0ivMSXm8doZ391JausdQ
	fFXr8GVgKGWxuyXGeJvSfi52quDYp0TAAIcZb59B9ORY1oxRebTGIctziyUCT8L9
	QueLm9VM9VjhHwOyEP8SS6rU/u1TRMV8T3fZ+jj98h2Ed9exim2dstO6g==
X-ME-Sender: <xms:K_FpZT1N2xHpKGa1QK9TszyH0GWiI3A3mc5QjQ6mvf4SwSdYyogiwQ>
    <xme:K_FpZSHN9gNozBunfgMHPgQVu_k_4S9LpYPWbb2yR8qSpXGFeZtG8GpBSt_PiUFSC
    _gurV8FebrnjCjFubA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K_FpZT5VLRyq7L0J3Ttt9kntPs34rf9ubufIk9CTsTVak8gsEsJoZA>
    <xmx:K_FpZY1r7ldOCyyL10MX5TaoWaBF6Rq9u_LrBIqSGkmrzWMY_9xfIw>
    <xmx:K_FpZWE9ZE1Op-EA9RLa41otswK1gi4T-66MV-A7LPT7wMtyDBJhCg>
    <xmx:LfFpZaNc_koo_gR9hz0jAbAGvo13fDijh0rLvdqL_CRyPBrs1lPr6Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75EBCB6008D; Fri,  1 Dec 2023 09:43:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
In-Reply-To: <20231201121622.16343-2-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-2-pstanner@redhat.com>
Date: Fri, 01 Dec 2023 15:43:35 +0100
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
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
Content-Type: text/plain

On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> 
> -#ifdef CONFIG_PCI
>  /**

You should not remove the #ifdef here, it probably results in
a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
GENERIC_PCI is not.

Alternatively you could use Kconfig or Makefile logic to
prevent the file from being built without CONFIG_PCI.

   Arnd

