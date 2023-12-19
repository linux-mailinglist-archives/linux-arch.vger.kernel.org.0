Return-Path: <linux-arch+bounces-1137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C468381923C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 22:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF481C250B4
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE483A29B;
	Tue, 19 Dec 2023 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXZqma5S"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC23A268;
	Tue, 19 Dec 2023 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D/sKTtPDAr5iC0AD14IbDBFeKu8tPn0IjS+CSIpmRPg=; b=eXZqma5SpEtW5PR+DeqkGwbNgo
	Tr+bTZpdqM6yceqzrZ7ODNM2R33dxSpnOAxpY9oShGTFvPwj0XbEcPkI058A8amXOsfGtgL5FLyhM
	s8cafTfPIHBQT+eFd4wkMaLwXym9YG7UjLPr8cDMDreZuxiJIawwNq5okpI0R8j2fu7SyR9f8aIHH
	cLlT9Jb5OaNFWwZgD17Ya5FN5N06TDRkdEZOtpLlP1bo2UeIfUn4vMUdtEFDb7KRovXyn6Hrq1DCy
	tSU5wCl6Uz6oCKw3My2ekgAVBgbgTwm7K2UwLUj23Tf8FrFfjfYyozCPOOh4kmKU0ceTz28CFp2+P
	gZAIgEJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFhc1-00FUrv-2C;
	Tue, 19 Dec 2023 21:26:49 +0000
Date: Tue, 19 Dec 2023 13:26:49 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] Section alignment issues?
Message-ID: <ZYIKmQj0H1YAJWlz@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Nov 22, 2023 at 11:18:10PM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> My questions:
> - Am I wrong with my analysis?

This would typically of course depend on the arch, but whether it helps
is what I would like to see with real numbers rather then speculation.
Howeer, I don't expect some of these are hot paths except maybe the
table lookups. So could you look at some perf stat differences
without / with alignment ? Other than bootup live patching would be
a good test case. We have selftest for modules, the script in selftests
tools/testing/selftests/kmod/kmod.sh is pretty aggressive, but the live
patching tests might be better suited.

> - What does people see on other architectures?
> - Does it make sense to add a compile- and runtime-check, like the patch below, to the kernel?

The chatty aspects really depend on the above results.

Aren't there some archs where an unaligned access would actually crash?
Why hasn't that happened?

  Luis

