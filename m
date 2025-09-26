Return-Path: <linux-arch+bounces-13781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E05BA20C9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB224A760B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512FC84A3E;
	Fri, 26 Sep 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/wf+Qak"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283272602;
	Fri, 26 Sep 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845989; cv=none; b=U2voLkL5DCTOOOYSzBcYAXpLN6CoUQO2/U5vXueeDfemJLzygDN7VWGgT3j7+UaeisoxUMyf9itReXN7FUEzJ0bIWZTXqjOnplZCF+ngsRUZKKcG0tFvnV+YUhcd76wDOzz9ewfNit8/hnbGgKI4QST1HBfBP6v1jTT2eQl+5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845989; c=relaxed/simple;
	bh=G5ktSeNiaC8LGS9vWNbPzm2FhwfBnuDcaIAHsflN7RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0b5dCC/2lLAYUAQquDGFhFXvPg0TSZffQ3z4n4hVeqj3Ychrc8OK0XaX47ggoy0wa6b8L6RugkeL6Qs6HrUbioxuq3VZwTlpt44GyAuPjhzUvhYUOwnVH8yZDgvvFHiLfZ0EgAMkPy7GcoRgCL3SipVHCS7TX8wzwf3L2YDln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/wf+Qak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00487C4CEF0;
	Fri, 26 Sep 2025 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758845988;
	bh=G5ktSeNiaC8LGS9vWNbPzm2FhwfBnuDcaIAHsflN7RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/wf+Qak/QgiK1GFX0aOrEH6Ki+SIjG4EgpvCCrSNJXqE3vH6KsmEL4oIOkZjV84n
	 rCnoWH89QMY/FHKD/PH7mezWeKERKxA+DXviKqqLbbBDlQf2HXY6hnr5saLCFVosCB
	 YtDu79hiAISvF63cOhaXG+PfzhNqbq/o6k+83K8OGyZLThQAHKdWROUQbGPC0MH398
	 XCbSay0T0IRiodAEEMtZjIt70/h+9Aklg1AKDrg+5RLazksiKKzWT+OxcVpuDjzEdF
	 Nw2lBHBoj6zHX4YG/liJ5+dWwNjvFyFGKNZO6YMCfovbd3DmZxfWfIhmmcmIIC2DDd
	 CvSKaeDUaE6/Q==
Date: Thu, 25 Sep 2025 20:19:43 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Qi Xi <xiqi2@huawei.com>, bobo.shaobowang@huawei.com,
	xiexiuqi@huawei.com, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] once: fix race by moving DO_ONCE to separate section
Message-ID: <20250926001943.GA1080352@ax162>
References: <20250909112911.66023-1-xiqi2@huawei.com>
 <3de848cc-0f01-4999-a4fc-1ff3cc11daa4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de848cc-0f01-4999-a4fc-1ff3cc11daa4@app.fastmail.com>

On Thu, Sep 25, 2025 at 08:14:35AM +0200, Arnd Bergmann wrote:
> I hadn't seen this until your ping and had a look since it
> touches asm-generic. The patch looks correct to me, thanks for
> addressing this and for the detailed patch description.

Agreed, I am not super familiar with this infrastructure but this seems
correct from my basic understanding.

> I think what happened is that nobody felt responsible for
> applying it, between the networking (which originally
> added the infrastructure) and kbuild maintainers (Masahiro
> did the last changes to this bit, but recently handed
> over maintenance to Nathan).

Yeah, that seems likely. For the record, I would not have felt
responsible for this code even if it was Cc'd to me since this does not
read as Kbuild material to me.

> I've applied the fix to the asm-generic tree for 6.18 now
> to be sure that it makes it in and gets linux-next testing,
> but it's not my area either really.
> 
> It would be best to have another review though. If Nathan
> or Andrew want to instead pick it up through one of their
> trees, please add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I do not have a strong opinion on whether you or Andrew take it (I think
it makes sense either way) but I do not think it makes sense for me to
take it via Kbuild.

Cheers,
Nathan

