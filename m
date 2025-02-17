Return-Path: <linux-arch+bounces-10164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9168A38E26
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7061734D2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D91A83E5;
	Mon, 17 Feb 2025 21:33:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380B1A23B8;
	Mon, 17 Feb 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827996; cv=none; b=PbVDEDsQDzULzIOuZNEKi3UUHzA4CJOc6oiGZknc3WS/GnxgGVnI623J6Cazyec+jMHOdfV5MuMc2058oKpWbx7hzlUXxE0l1YJqJmkU9kft0+HucjCPD9PHeRTc/f3obGgCEUN3X5dJ6oaEJreWoH/MtoKC7irns6YBfDQgAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827996; c=relaxed/simple;
	bh=iDsAr9NnBkZW0wpiPEn8TDIJEH+o7Nzxq5Wj0b6UqE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8/QeEuofWbyuTHIlg/v0UhlI8lRy/hPHVeUmOfHzjnuEtA/yK6EIQ0w2zQD1tKDat81Y7ykSkS/n+pSXg96/+kcuFcl+ZgcdOSsT1zwMjXI9tSLtkSYY5EAOrh1KDP58Qmrm5Ry7LO8yIbGbdX5Ivz6lmblWGzdz4QwjB4H8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723ACC4CED1;
	Mon, 17 Feb 2025 21:33:12 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arch@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	nd@arm.com
Subject: Re: [RESEND v4 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Mon, 17 Feb 2025 21:33:10 +0000
Message-Id: <173982794521.4020985.15838989967891150260.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113170619.484698-1-yury.khrustalev@arm.com>
References: <20250113170619.484698-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 17:06:16 +0000, Yury Khrustalev wrote:
> Add PKEY_UNRESTRICTED macro to mman.h and use it in selftests.
> 
> For context, this change will also allow for more consistent update of the
> Glibc manual which in turn will help with introducing memory protection
> keys on AArch64 targets.
> 
> Applies to 5bc55a333a2f (tag: v6.13-rc7).
> 
> [...]

Applied to arm64 (for-next/pkey_unrestricted), thanks!

[1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
      https://git.kernel.org/arm64/c/6d61527d931b
[2/3] selftests/mm: Use PKEY_UNRESTRICTED macro
      https://git.kernel.org/arm64/c/3809cefe93f6
[3/3] selftests/powerpc: Use PKEY_UNRESTRICTED macro
      https://git.kernel.org/arm64/c/00894c3fc917

-- 
Catalin


