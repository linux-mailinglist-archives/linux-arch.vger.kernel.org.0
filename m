Return-Path: <linux-arch+bounces-2498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E999085BC9E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 13:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8811F233C4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC5469DE4;
	Tue, 20 Feb 2024 12:54:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD25D8E0;
	Tue, 20 Feb 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433660; cv=none; b=EWcImIKJ7lIy+KxQX+VyHmoiYcyCz3MJPVq9bwWw8GIsHhp7R1krYB3Pi+QHMeXgTaUXBXKgRAxDZ4ZXP5//6oNTQhfPRA/UL8n8eZjwFLuHp0wmQnVJPywr/bxB0B5V0WBBfwQAD2592E2dycLRGizPxqBP54/IMJ7Vywie3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433660; c=relaxed/simple;
	bh=entqg/P13xXezXypx1Ml6MjY9tYUqQQAJjKH5cS0sxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUSaAdoQtgJwLCeeUSKdlbkqYvYZ6BRAx65Dl1sIktqdsmntzYf9bF2RHD4PsxpjJwuHwVUX5rn0DFwczLEcQVNwGYTp4DQuzzfWLGMRx2Bi9jI9cU9oENT47WL8PjK6jR9E8SvRwQzZ+I14Yppi0NBpJrpaKPJd9lHzBqRzX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfK9N0vp6z4wnr;
	Tue, 20 Feb 2024 23:54:16 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter Bergner <bergner@linux.ibm.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Nick Piggin <npiggin@au1.ibm.com>, Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
References: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
Subject: Re: [PATCH v2] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector, entries
Message-Id: <170843363898.1291121.4882822831062369983.b4-ty@ellerman.id.au>
Date: Tue, 20 Feb 2024 23:53:58 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 16:34:06 -0600, Peter Bergner wrote:
> Changes from v1:
> - Add Acked-by lines.
> 
> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
> access by the __builtin_cpu_supports built-in function.  The TCB space for
> the HWCAP entries - which are created in pairs - is an ABI extension, so
> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
> problematical.  Define AT_HWCAP3 and AT_HWCAP4 in the generic uapi header
> so they can be used in glibc to reserve space in the powerpc TCB for their
> future use.
> 
> [...]

Applied to powerpc/next.

[1/1] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector, entries
      https://git.kernel.org/powerpc/c/3281366a8e79a512956382885091565db1036b64

cheers

