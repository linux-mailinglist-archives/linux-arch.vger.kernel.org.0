Return-Path: <linux-arch+bounces-13353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BBB3E2E6
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4304F7B0521
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBC32BF3F;
	Mon,  1 Sep 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvN7JTzn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88F3277B3
	for <linux-arch@vger.kernel.org>; Mon,  1 Sep 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729627; cv=none; b=RR5cb9lIFSMGAz6O4w+lUUv6saU6k3bHZeD9hGJgU66zbUdNkG8MbLVr7TNdZ9FCp4A4Tyl4M+1AgZ4PDar5UYa2vZDd4lJKTSpyqd9sh+jbZT3jNawKfxE+vJENCLbfvJjybt1CsdhsjoqAPAYvb4IrhsC6XJmPuzE8KWloTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729627; c=relaxed/simple;
	bh=NI3j//K+uv280Ub1AAwzmSKy0oNo3n7zmmHOVS4hqJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQC3Cc7fFOHWvHxLQP5/gVmkE3fHNTxGjD+58B6yxYqzzAvlEa3wpYJSQnc/OGGf8L/OCFIiMpZasNwRb1gnwBJJJL4CULAppUxNqig7vMmcFeUH8bLlqYe4O7voInFmc+I1X6jfzU0fsu4GjII9u439mVCq8TrViQ8cYlUOW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DvN7JTzn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so2639390f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Sep 2025 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756729624; x=1757334424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvXFM2+EDhInaja9QZo9cQmXYbU073wpqmRBXkRFUBM=;
        b=DvN7JTznmTgh9C5aWlllMdoPjvzuLsP2rqj0D1Rp6pMS1HNU+9dHfXvc3l7BLcnUQx
         y8NnaUXXZlO8FQ9BUqCFPLJCGZ8RWM00pfuFH0WzyCW7oR1tBGVCTa0jOCupyiMxp/0Y
         W0arLHgpl728aSFjv8Hqd3b7IOYygQ2zmdYzv4Htd2iodz99XlNZQeQmbrDGjMvFXc8u
         FKcWwqwsbpH+ZjZacq/PU7sksS6QMv15u94T9D9EXqr60KEPW/yZf5B7toQk2ldCxSoP
         pR37goby4lon67/Xo5BZzuHYJRpEzEEgsZNrpRGSOYuz20iDVNkknDg7zohLcCiKJLaF
         ZGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729624; x=1757334424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvXFM2+EDhInaja9QZo9cQmXYbU073wpqmRBXkRFUBM=;
        b=rUguw2PZiZfZa9PYq62rBdJRgRhnAtmwRjg7Eow1VviLEhl+H7Tp9m8wxLfCjnUy74
         35ru4TCU0m9HL8cfNT+Trax174SVQ3mROv6aw7BMnaI55Shi05VuUA2zATmAAMlO3JAK
         +DsbwRU1SKcDZiJp0hFCVeYhQe+4FikVyGiiGjcLG//FWlcXUBKRa2WPqvokqR0Z1wxZ
         CujteCwH6bzAuXAn9VdrW8TXtJi320pKiCawXYBm/p6xETXx6kIN1fgu6X6uS4FBw28f
         DKzi2kys680/8MBJZ6BNuVp3ORbVZrE5f93PO/3LmDe3PrPrCEsABjkagjQI6qRqgmvR
         lPzA==
X-Forwarded-Encrypted: i=1; AJvYcCX3WK/SCWI57/q88Rorg+JjznkzgroYqD3Xij6ERi4XBr5jSuLaUsOY37fK6UiMCCk72e5541brTbT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFDNQcdxAYLDKvQhywGJ33+DbzJ0yv7F+yz//o2jgNXuo9MCx
	jk1HE5AKhaDroGJeOlXgjgqwCKIst4QMSnlIklrwIA9VxE1+l+6AOwWV9IhpkykkKhQ=
X-Gm-Gg: ASbGnct2VxvfGuaoB9kWm/QUwIlS80LeZ2z330cYCyNIhfILAlvIPgqrH6pILudOmBb
	phjMb2x05ApTlzkd2RvDxGd4okDUDZdZCgu5ID5HBBfbT6pa2bL13c46lLRRHEDy4d9+Nxe1xYu
	YJL7rGpB+fwhWl80MzZDL0y5JUmfMdtyUNR2aYO6+8uPyx/Lf/tCjrkHOfY8TyUw4rFCu1duHpy
	EbFNB5PJD4YSbr/KdjH8i7xPFNu8C1S2qJN7Uu5lpMiJi4wE3Ie1A50FP13Yv8B3XAATGZkaTCa
	+WuUAFy/3+SzmILOacHZsX/f+jcPaY+Fe/WG2mHGzLBEcogN6rHIn/5QP2NlpP7DtUHCJXt16k6
	jxJwd9lGI9XvcOScTf4imkYlTnSQJNg/hG7KwcuENDC8S/KYGlAKWRw==
X-Google-Smtp-Source: AGHT+IGMZj0MUqoNS8l03J940dxpE/Oa7+eZtp6hkgsi4bqmdFUhhinsYeDmT1bsO+4zfR2NPsVVzA==
X-Received: by 2002:a05:6000:240d:b0:3d7:c86:800f with SMTP id ffacd0b85a97d-3d70c868524mr2579250f8f.60.1756729623615;
        Mon, 01 Sep 2025 05:27:03 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7330e4bc9sm3325617f8f.10.2025.09.01.05.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:27:03 -0700 (PDT)
Message-ID: <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com>
Date: Mon, 1 Sep 2025 14:27:02 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Hi everyone,
> 
> This patch series proposes a new, scalable mechanism to represent
> boolean flags for exported kernel symbols.
> 
> Problem Statement:
> 
> The core architectural issue with kernel symbol flags is our reliance on
> splitting the main symbol table, ksymtab. To handle a single boolean
> property, such as GPL-only, all exported symbols are split across two
> separate tables: __ksymtab and __ksymtab_gpl.
> 
> This design forces the module loader to perform a separate search on
> each of these tables for every symbol it needs, for vmlinux and for all
> previously loaded modules.
> 
> This approach is fundamentally not scalable. If we were to introduce a
> second flag, we would need four distinct symbol tables. For n boolean
> flags, this model requires an exponential growth to 2^n tables,
> dramatically increasing complexity.
> 
> Another consequence of this fragmentation is degraded performance. For
> example, a binary search on the symbol table of vmlinux, that would take
> only 14 comparison steps (assuming ~2^14 or 16K symbols) in a unified
> table, can require up to 26 steps when spread across two tables
> (assuming both tables have ~2^13 symbols). This performance penalty
> worsens as more flags are added.
> 
> Proposed Solution:
> 
> This series introduces a __kflagstab section to store symbol flags in a
> dedicated data structure, similar to how CRCs are handled in the
> __kcrctab.
> 
> The flags for a given symbol in __kflagstab will be located at the same
> index as the symbol's entry in __ksymtab and its CRC in __kcrctab. This
> design decouples the flags from the symbol table itself, allowing us to
> maintain a single, sorted __ksymtab. As a result, the symbol search
> remains an efficient, single lookup, regardless of the number of flags
> we add in the future.

Merging __ksymtab and __ksymtab_gpl into a single section looks ok to
me, and similarly for __kcrctab and __kcrtab_gpl. The __ksymtab_gpl
support originally comes from commit 3344ea3ad4 ("[PATCH] MODULE_LICENSE
and EXPORT_SYMBOL_GPL support") [1], where it was named __gpl_ksymtab.
The commit doesn't mention why the implementation opts for using
a separate section, but I suspect it was designed this way to reduce
memory/disk usage.

A question is whether the symbol flags should be stored in a new
__kflagstab section, instead of adding a flag member to the existing
__ksymtab. As far as I'm aware, no userspace tool (particularly kmod)
uses the __ksymtab data, so we are free to update its format.

Note that I believe that __kcrctab/__kcrtab_gpl is a separate section
because the CRC data is available only if CONFIG_MODVERSIONS=y.

Including the flags as part of __ksymtab would be obviously a simpler
schema. On the other hand, an entry in __ksymtab has in the worst case
a size of 24 bytes with an 8-byte alignment requirement. This means that
adding a flag to it would require additional 8 bytes per symbol.

> 
> The motivation for this change comes from the Android kernel, which uses
> an additional symbol flag to restrict the use of certain exported
> symbols by unsigned modules, thereby enhancing kernel security. This
> __kflagstab can be implemented as a bitmap to efficiently manage which
> symbols are available for general use versus those restricted to signed
> modules only.

I think it would be useful to explain in more detail how this protected
schema is used in practice and what problem it solves. Who is allowed to
provide these limited unsigned modules and if the concern is kernel
security, can't you enforce the use of only signed modules?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3344ea3ad4b7c302c846a680dbaeedf96ed45c02

-- 
Thanks,
Petr

