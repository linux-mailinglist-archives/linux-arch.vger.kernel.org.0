Return-Path: <linux-arch+bounces-8843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E79BBCC5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5252830BD
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C21CB537;
	Mon,  4 Nov 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqfYcLrZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6571C9EAF;
	Mon,  4 Nov 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743358; cv=none; b=Z7u+IwoHCk//MFgJjfX3VDx4pAbCN9m9O2Bd+1K8JRNRImlKTHjNrt3AgFu5Wa15E8dBNydN9X5JYOxZNctpC5jjshNl3OrHNC6GrNse+UCKD3GTplTxctSVJIVMwYDoPFI5BKNDFo+rf4kYgFHA0qd8Kz4PiUQZiAFHTZX2oqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743358; c=relaxed/simple;
	bh=yP3AzGld8FzxH9tOKTTB2o68WwDina53uBS0weY4OLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojbjernYbimiPw3mi+/5ahtY6ouGgOgLPDZFh02nycUVa55pM7bzuaztn5p4g3v8xYt89wyxJiL9yI12QCfqYuFYvG0l73OjW29sj4JImSFNa34LSH6N462QJqkYETp1fjMf92ryPz2PbOxbc9GnvHmeiYwH4Dc38OfUvoZmNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqfYcLrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39563C4CECE;
	Mon,  4 Nov 2024 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743357;
	bh=yP3AzGld8FzxH9tOKTTB2o68WwDina53uBS0weY4OLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqfYcLrZDS69ybYADumbTjdNmAfqdeBwuYAUOic1Rj/10q6ggUWZLiDYkaCPK5aEH
	 zmu4eoFdrAUYUyqH09b4NU313JKh+C+MQEQsFnA5/S8o13oZAoiRFCI0ipBp/CIHrD
	 YYR8+oHSwIc4iDVej/js9QR02RkzVmrsSiipqECclpGLHtQIVef7t26FeafViOEBdl
	 g59QyyQs5LNimTKrFAcd2N9fUvHgiInhDc8gbGEok4vZSEw9RJzDsGauezslhgF4Jt
	 Un3HrYzRz3V3ubZQNfJ91sOIdTj3MsTjyaJG0bnzVO3UlO5jzUNETVnJiGJm8JQFgg
	 eaDC1K1A+1PYA==
Date: Mon, 4 Nov 2024 18:02:35 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 16/18] jbd2: switch to using the crc32c library
Message-ID: <20241104180235.GB1049313@google.com>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-17-ebiggers@kernel.org>
 <20241104160136.GI21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104160136.GI21832@frogsfrogsfrogs>

On Mon, Nov 04, 2024 at 08:01:36AM -0800, Darrick J. Wong wrote:
> Same comment as my last reply about removing trivial helpers, but
> otherwise
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> If you push this for 6.13 I'd be happy that the shash junk finally went
> away.  The onstack struct desc thing in the _chksum() functions was by
> far the most sketchy part of the ext4/jbd2 metadata csum project. :)

It will take a bit longer I'm afraid, since this patchset depends on patches
that are currently enqueued in three different trees for 6.13.  My current plan
is to target 6.14, and get this series into into linux-next shortly after the
6.13 merge window closes.

- Eric

