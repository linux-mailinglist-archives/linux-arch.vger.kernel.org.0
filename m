Return-Path: <linux-arch+bounces-12344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48388AD938B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC951E4D0B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F557221727;
	Fri, 13 Jun 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhivCur+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421492E11B5;
	Fri, 13 Jun 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834731; cv=none; b=HaGarC9OnRlElahiis/CeOXeRG8fW/rIKhZBKEUIAdGRqTym5G5gKACZjqtHuMoKRloU1ZYB3klLZh/p9sopyNQbW6tGzDPVq4J8i3D/wqNfflWjQNjPDgEdXi1p8VA+XhPqk38of2ZiBM/w5amX2EGTC5hfRautlYaDCJR7eSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834731; c=relaxed/simple;
	bh=MwLvd5PG7WoLPNV5X3+UTldK/899ju4MNdrqiosDJ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8B7u0E+bYv99iwsHQAe2TCbBucBkiL8Ku8BOQqcgsOMl0LMXE+c0EaGyvi32tNYCdRH3yUgFSth3InU1zlbD26fsacpbctsuTFDgzKpzzdIY5PBpM4jgxsXgDyCCyyEgIe7k11KEWVIL9s9Z8xPFGPLlhSDdgSIYwg+YkMGXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhivCur+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43202C4CEEB;
	Fri, 13 Jun 2025 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749834730;
	bh=MwLvd5PG7WoLPNV5X3+UTldK/899ju4MNdrqiosDJ9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhivCur+l0uxRrXdj3m3GKjsKlQNT6CXQx3iCBvVkXSvE4m7EvCcVuRfY6gZB5DtI
	 RrJabvRIGIr3L4g87xf0gTfQDs/DflrsqDAj5QlhN5vplNG9fEENywbAPzXW3gnNlq
	 m+coGK+eBLQeJtsoxM3fU4c5Xpiy8kfmTbUODa1wg4jIDHjdtxdql01cyMgso0UG9q
	 znLaUKdE+SbabPCvrEijY1od4XSYKiQECxgj+txYdWIoB7IUqgUD3yiEVggSkRo5Am
	 oG2oDjLPd9qcjldUhG53BMbb8wG7cjW4jHsngIK0FAWMIuyciYpkyJRP9+ahUBrIUW
	 mqv3dY3gjk5ZQ==
Date: Fri, 13 Jun 2025 10:11:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 09/12] lib/crc/s390: migrate s390-optimized CRC code
 into lib/crc/
Message-ID: <20250613171143.GB1284@sol>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <20250607200454.73587-10-ebiggers@kernel.org>
 <aExLZaoBCg55rZWJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aExLZaoBCg55rZWJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Fri, Jun 13, 2025 at 06:01:41PM +0200, Alexander Gordeev wrote:
> On Sat, Jun 07, 2025 at 01:04:51PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Move the s390-optimized CRC code from arch/s390/lib/crc* into its new
> > location in lib/crc/s390/, and wire it up in the new way.  This new way
> > of organizing the CRC code eliminates the need to artificially split the
> > code for each CRC variant into separate arch and generic modules,
> > enabling better inlining and dead code elimination.  For more details,
> > see "lib/crc: prepare for arch-optimized code in subdirs of lib/crc/".
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> ...
> 
> Hi Eric,
> 
> With this series I am getting on s390:
> 
> alg: hash: skipping comparison tests for crc32c-s390 because crc32c-generic is unavailable
> 
> Thanks!

I think that's actually from "crypto/crc32c: register only one shash_alg"
(https://lore.kernel.org/linux-crypto/20250601224441.778374-3-ebiggers@kernel.org/),
not the patch you replied to.

Those self-test warnings are expected.  But I guess they are going to confuse
people, so we should do something to make them go away.

I think we should do what I've proposed for SHA-512: stop worrying about setting
the cra_driver_name to something meaningful (which has never really worked
anyway), instead just use *-lib, and update crypto/testmgr.c accordingly.

I'll send out patches that do that.

- Eric

