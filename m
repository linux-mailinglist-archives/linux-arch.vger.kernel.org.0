Return-Path: <linux-arch+bounces-5929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BDD945D52
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7101C2116E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4631E212B;
	Fri,  2 Aug 2024 11:40:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178E1E286D;
	Fri,  2 Aug 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598850; cv=none; b=NSSZV7Z5fmxzpbuB0madsvehf9xr3GaarQXXcU5pZ9Tq3CdWTelUUlwUjN88cvIf55Ag8MZnFGUGjHe4pBZF2RvvwBOf1QbrOBKQjj1AsCONg9qfue+7sW1yhzMKOnQ7x20NIijrMel/pQxLsNl9mK1HuBFjffHtSlVxJJ0e39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598850; c=relaxed/simple;
	bh=E8Wj2Qe826SSpgPO1+n1aolYqoxkadAQ1V4WZVutK0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDsyBK+9gvVmxkg/KHiHUR/JacbFAuFu+xIO0bfr+O1PgC+dnOjEqcYhb8S2T88M04awZMjiHUzuD8CI3nJyBZG+AYmdDidLFPNlfqENpkqRoTsVRhYiePtXwOEsTp+QaK+Ze052bs6JJxaxIQanELuvWYhnWCamYjgpEY9trTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wb3F14cCrz9v7Nc;
	Fri,  2 Aug 2024 19:16:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AB0D0140661;
	Fri,  2 Aug 2024 19:40:32 +0800 (CST)
Received: from [10.45.147.218] (unknown [10.45.147.218])
	by APP2 (Coremail) with SMTP id GxC2BwB3lMGhxaxmYY9lAA--.45712S2;
	Fri, 02 Aug 2024 12:40:32 +0100 (CET)
Message-ID: <07bfa8d2-c4b1-4338-8a0f-52eba7f7f600@huaweicloud.com>
Date: Fri, 2 Aug 2024 13:40:15 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add the dedicated maillist info for LKMM
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney"
 <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20240703162616.78278-1-boqun.feng@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20240703162616.78278-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwB3lMGhxaxmYY9lAA--.45712S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF18Ww43CF48WFy5XrykuFg_yoWDJwcE9a
	n7G3WIgr1DCFyjkw4kCF9Fyrn09rZ7CF1fW3Waqw43Xa4DGrsxt398KwnY93WDX348Cr4q
	ya1fGFsagr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7sRiuWl3UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Awesome, thanks!

Am 7/3/2024 um 6:26 PM schrieb Boqun Feng:
> A dedicated mail list is created for Linux kernel memory model
> discussion, and this could help more people to track down memory model
> related discussion, since oftentimes memory model discussions would
> involve a broader audience. Hence add the list information into the
> maintainers entry of LKMM.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f2047082073..a77bd8a49cd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12796,6 +12796,7 @@ R:	Daniel Lustig <dlustig@nvidia.com>
>   R:	Joel Fernandes <joel@joelfernandes.org>
>   L:	linux-kernel@vger.kernel.org
>   L:	linux-arch@vger.kernel.org
> +L:	lkmm@lists.linux.dev
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>   F:	Documentation/atomic_bitops.txt


