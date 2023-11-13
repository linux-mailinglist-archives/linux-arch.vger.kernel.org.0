Return-Path: <linux-arch+bounces-187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B587E9539
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 03:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73282281164
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 02:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E808483;
	Mon, 13 Nov 2023 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D3847E;
	Mon, 13 Nov 2023 02:49:28 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4ED115;
	Sun, 12 Nov 2023 18:49:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4STDR45zpTz4xWP;
	Mon, 13 Nov 2023 13:49:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
In-Reply-To: <20230922080636.26762-1-tzimmermann@suse.de>
References: <20230922080636.26762-1-tzimmermann@suse.de>
Subject: Re: (subset) [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
Message-Id: <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>
Date: Mon, 13 Nov 2023 13:45:22 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 22 Sep 2023 10:04:54 +0200, Thomas Zimmermann wrote:
> Clean up and rename fb_pgprotect() to work without struct file. Then
> refactor the implementation for PowerPC. This change has been discussed
> at [1] in the context of refactoring fbdev's mmap code.
> 
> The first two patches update fbdev and replace fbdev's fb_pgprotect()
> with pgprot_framebuffer() on all architectures. The new helper's stream-
> lined interface enables more refactoring within fbdev's mmap
> implementation.
> 
> [...]

Patches 3-5 applied to powerpc/fixes.

[3/5] arch/powerpc: Remove trailing whitespaces
      https://git.kernel.org/powerpc/c/322948c3198cf80e7c10d953ddad24ebd85757cd
[4/5] arch/powerpc: Remove file parameter from phys_mem_access_prot code
      https://git.kernel.org/powerpc/c/1f92a844c35e483c00bab8a7b7d39c555ee799d8
[5/5] arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
      https://git.kernel.org/powerpc/c/deebe5f607d7f72f83c41163191ad0c1c4356385

cheers

