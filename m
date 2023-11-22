Return-Path: <linux-arch+bounces-401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99E7F52AD
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3D01C20A57
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E71C6AC;
	Wed, 22 Nov 2023 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YtP/GvNT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A681C2AC;
	Wed, 22 Nov 2023 21:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EEC433C8;
	Wed, 22 Nov 2023 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700688956;
	bh=dUf7J8K5pInX6ApRsBDZomkEu1RtnSBNH2JHXiSX7sY=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=YtP/GvNT2rI51Ptztgba6YuBdIJ6WPXSCcClZeCkvVekUWZLIJDyWDxopcNGoFjtl
	 0RPiAaKPgWqPzWGSuWzOL5EXxSZzsS3VnvtYtaecgsPSmm2mKEXSit4VD0mbk+FwjD
	 ZF0NTHlA1pRC4uG7AMRgH6DD33mm2a97R3Ay4+Vc=
Date: Wed, 22 Nov 2023 13:35:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com, Gregory Price
 <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-Id: <20231122133555.b7fc6cdefae0395d34a4cd1c@linux-foundation.org>
In-Reply-To: <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
References: <20231122211200.31620-1-gregory.price@memverge.com>
	<20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 13:33:48 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:
> > echo "default" > /proc/pid/mempolicy
> > echo "prefer=relative:0" > /proc/pid/mempolicy
> > echo "interleave:0-3" > /proc/pid/mempolicy
> 
> What do we get when we read from this?  Please add to changelog.
> 

Also a description of the permissions for this procfs file, along with
reasoning.  If it has global readability, and there's something
interesting in there, let's show that the security implications have
been fully considered.

