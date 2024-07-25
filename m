Return-Path: <linux-arch+bounces-5635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D529E93CA14
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A1D1F22D10
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1105C8FC;
	Thu, 25 Jul 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V9Wq8XRw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8B225D9;
	Thu, 25 Jul 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941545; cv=none; b=Aw/PHdgmaRBLJC8gBy/tKQr8mPY5MKCcoyj6xZLd3+6xCw9/Gj0czN25IZ1AWFQkgVcEE5RQ+3//1S/iykOb3QhH8nHbL1fhH6p4rSVmEX/WJsqllBl3aKAe2xNdaH1mtimEwe+7DDRVnm4QLnKv7e6wG4OOmVHqXp1lJecu9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941545; c=relaxed/simple;
	bh=ntBXGXoE2ffu55Z5gIRSYR+MGwUgSOr2KOTGcsiWvBQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B6HBFA8eYG3zCnfzUjkC9p8cSNNrp8UGM8MOhlKyVXIhqDrGfipdr5tuVZZSqUmoR65jv1h11YUHXfLrguWxg6XXPjR+oalRP6HaVAUixNkp0j4x9oKegqYgAl5cF09vTwYcTBQSph4MTsJApMvNlhWOgPPSSTjSCWEODg3COgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V9Wq8XRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4940C116B1;
	Thu, 25 Jul 2024 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721941544;
	bh=ntBXGXoE2ffu55Z5gIRSYR+MGwUgSOr2KOTGcsiWvBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V9Wq8XRwdatRERKndAJuqf0sjGbAuf2LQqaqVMdzuN1FBPZ/yd6Qp7/L8Dy7Wdu1Y
	 4PAX71+93cke8N9+bB4Xaoz6g4zGT/FJZIRbS5d4jjq3OWDlDo5hC05ksnHaelhfQh
	 SgrCt+EX+T8HzefXNsK4/6gIGWuSXyWA6N1xm2QA=
Date: Thu, 25 Jul 2024 14:05:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
Message-Id: <20240725140543.9601ffdb94b5a6103dfd906f@linux-foundation.org>
In-Reply-To: <20240725054808.286708-1-anshuman.khandual@arm.com>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 11:18:06 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This adds support for GENMASK_U128() and some corresponding tests as well.
> GENMASK_U128() generated 128 bit masks will be required later on the arm64
> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.

If this will be required for ongoing ARM development prior to the 6.11
release then it would make sense for these changes to be carried in the
relevant ARM tree.



