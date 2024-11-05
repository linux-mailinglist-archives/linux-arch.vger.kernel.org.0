Return-Path: <linux-arch+bounces-8848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8F9BC2A3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 02:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DE31F23591
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52599210FB;
	Tue,  5 Nov 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cilUS0qQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866518641;
	Tue,  5 Nov 2024 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770470; cv=none; b=JdWjAMnznIv6Wfb9HDcLf3q5cfAqpVOwpO8rhAgM8gFZpUAE34N7eKgUIUeB3bn4kM1pKQ8pp/LTJA7JRNPlDtsUuRbot8k181h9D0ttnadbZFOU8mw544lC5KBo+YuBOvrE7nb8XRPunXElJdBmX/jYxoQEftiMc/R9aUj7Fzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770470; c=relaxed/simple;
	bh=pZqyeDU4Z0xb82ka1rqo9zPh5E+ZbwXvL5ApzcS2al4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BnS/eclFVmp4wRVyRxbcMa1U60UqDxS4JL6LqV1fIx5ckxUZdVtlcgITSy+0n9HhWyNhtgzkr9EaS0po4GNuyebFzVvnn/SqonjSYJtyd0bn/c0VG8005cCi2Opr2gfqJj+QMHgl7gFyv9zsyuNGkiH8H09SR1fRYT/M307uPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cilUS0qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B7C4CECE;
	Tue,  5 Nov 2024 01:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730770469;
	bh=pZqyeDU4Z0xb82ka1rqo9zPh5E+ZbwXvL5ApzcS2al4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cilUS0qQCFaxNF3zH63qgUIqVpBsK5ZAO2+Mc4CrXmk6QZIa3ZA/1eyWd894pH2td
	 p6DeOBI4b44PBAllxDSwZ+pvc/5OEkcYzKgLtcgnvluIpjNagN96SxdO1hq1RTBHL4
	 IsHQ3dUtDassq5aGIJOJqxs+MkAOhLYww1/sRgfew7akFKeqGOT8zYLFCTpqAtJETh
	 hetvPOAoOKDF42PLByagmL9JEdRSFvR3DT2TRaUD4mTfYhVrokbWecXm5y2cdsb4O7
	 uykYoTN0CALyatfk7dtT2vPJ/mDxiOvw5DHvt59QcW4RICZcRPoNv9l/f+5h04HOGk
	 wE3h4ii4bPJsw==
Message-ID: <43d8b52e-5e5b-4a37-9a18-6ac392048d92@kernel.org>
Date: Tue, 5 Nov 2024 09:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-ext4@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [f2fs-dev] [PATCH v3 17/18] f2fs: switch to using the crc32
 library
To: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-18-ebiggers@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241103223154.136127-18-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/4 6:31, Eric Biggers via Linux-f2fs-devel wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32() library function takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

