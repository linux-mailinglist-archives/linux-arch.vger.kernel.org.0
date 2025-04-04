Return-Path: <linux-arch+bounces-11284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8CBA7C10D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A1B3A9DC6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBDC1FCD09;
	Fri,  4 Apr 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="MerP6PTL"
X-Original-To: linux-arch@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD51FC7C7;
	Fri,  4 Apr 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782211; cv=none; b=aMIcr1AGxpsaFAz0AjDGHlX+SpV3ElPfZTy+55cz1qOCIqPDfYCToZFocf128un1OIsAllIuaFm6Iv+kvhPvab+3ohTDhFzbXejymgs7idG5SEYtENidHfFUkQl9unrazX6/9nqrAgGlfCffu4xZ3Q3KvSt3Y8A6x9DRF1+WMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782211; c=relaxed/simple;
	bh=ABpsVb0a/UQlWsessKYFH/LthH36DYFIjoPCIz9l3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIrGw+PF7QUZXKPMMijLshd7PnxKjnktLKlTOHLQovVi8E9Y7CIWA4V5RGHuNCZbQyq9/XF3sGcxhG+IYWT5/wnoXP6jaquv/xmgxzSbGz0hxEmQuse/XPBwEGziEc7cJ2GlSjRAlIsHa/iDWe3yjye6BVhf+DQxQsearzpGUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=MerP6PTL; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Xn/hH6/7ss6uP5i4wKjZNjVXjJNOK/mVv5dxW21kIE=; b=MerP6PTLL1xnXQ1BsDkbiOnTLj
	UfWowf6P5MrqIueDuE2fsf/9BUYR7dM5myL3b4Re9VetvFakSaj8YDPcP4zThfrVeSdoak3TUHfVI
	dKC6zkKKPqOWIHI0VbV3tYAJ4UWmkmmYa7RHKJ/x39o6ldZoX9P0WkgdPZYqz+psDRz0/UXaNVdxW
	mu0p1FrnjtTOmm2OtdZYARGvV+nq3O9DnIuBsnI2xuRPkvZd96oGnuEdTloTLOuPqGg1TQC0TuWyc
	zdFjwJFNz+I9INy9kmsjADBRZBoRPZeAfhffLnJRjsLlclRgx0QDxRuz/pMDmC4c5daXMD/639p5P
	AZd8VS+Q==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1u0jPL-00BgSX-Ku; Fri, 04 Apr 2025 16:56:40 +0100
Message-ID: <a92dad03-664b-46a6-9761-b788c47ff6f4@codethink.co.uk>
Date: Fri, 4 Apr 2025 16:56:39 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Implement endianess swap macros for RISC-V
To: Ignacio Encinas <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-arch@vger.kernel.org
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 03/04/2025 21:34, Ignacio Encinas wrote:
> Motivated by [1]. A couple of things to note:
> 
> RISC-V needs a default implementation to fall back on. There is one
> available in include/uapi/linux/swab.h but that header can't be included
> from arch/riscv/include/asm/swab.h. Therefore, the first patch in this
> series moves the default implementation into asm-generic.
> 
> Tested with crc_kunit as pointed out here [2]. I can't provide
> performance numbers as I don't have RISC-V hardware yet.
> 
> [1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
> [2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>

I'll try and get these tested with my big-endian riscv qemu and verify
if they work there.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

