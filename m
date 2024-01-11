Return-Path: <linux-arch+bounces-1352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FC82B547
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1D428454D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9356476;
	Thu, 11 Jan 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPPtBjPT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985955C18;
	Thu, 11 Jan 2024 19:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE49C433C7;
	Thu, 11 Jan 2024 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705002004;
	bh=DmkLUwPO5pHCJHvVcwPy1P4sgjTzQNNak+Eq1cUdG4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPPtBjPT+YAd4ocTNd3PGbSKeEby62sm5DsaPgCv2HqVIW9AA61WpCKjUG1nFowUj
	 3KfWsd59L33mr3lPW1pODJ4DxPp3c0FvcL65M+M43Xd0dsozkiXoWTzMQXYyp+ok+1
	 Cb30aWs3Sxk5AodiSlMI4eMG+NABT1HgniB893pjpYDswpLiHA/yPSOP9UoGeJLbKt
	 bnTkQNlGsDQqy8YOmI7KSXeLlghLdU+zlsbZoTu+RaMYkcWjxf+xdeMOQ8myzu+KXS
	 4DFQ7cH+eAqKWFGmhszUBwC2NDKu/wiPRUDEP+5/MhjNc4xXnfccYuJTOa5a8NwKDV
	 Z7nFRX4xsl/qg==
Date: Thu, 11 Jan 2024 12:40:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arch@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/bpf: Update LLVM Phabricator links
Message-ID: <20240111194001.GA3805856@dev-arch.thelio-3990X>
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
 <20240109-update-llvm-links-v1-1-eb09b59db071@kernel.org>
 <6a655e9f-9878-4292-9d16-f988c4bdfc73@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a655e9f-9878-4292-9d16-f988c4bdfc73@linux.dev>

Hi Yonghong,

On Wed, Jan 10, 2024 at 08:05:36PM -0800, Yonghong Song wrote:
> 
> On 1/9/24 2:16 PM, Nathan Chancellor wrote:
> > reviews.llvm.org was LLVM's Phabricator instances for code review. It
> > has been abandoned in favor of GitHub pull requests. While the majority
> > of links in the kernel sources still work because of the work Fangrui
> > has done turning the dynamic Phabricator instance into a static archive,
> > there are some issues with that work, so preemptively convert all the
> > links in the kernel sources to point to the commit on GitHub.
> > 
> > Most of the commits have the corresponding differential review link in
> > the commit message itself so there should not be any loss of fidelity in
> > the relevant information.
> > 
> > Additionally, fix a typo in the xdpwall.c print ("LLMV" -> "LLVM") while
> > in the area.
> > 
> > Link: https://discourse.llvm.org/t/update-on-github-pull-requests/71540/172
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Ack with one nit below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

<snip>

> > @@ -304,6 +304,6 @@ from running test_progs will look like:
> >   .. code-block:: console
> > -  test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexpected error: -4007
> > +  test_xdpwall:FAIL:Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5? unexpected error: -4007
> > -__ https://reviews.llvm.org/D109073
> > +__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d
> 
> To be consistent with other links, could you add the missing last alnum '5' to the above link?

Thanks a lot for catching this and providing an ack. Andrew, could you
squash this update into selftests-bpf-update-llvm-phabricator-links.patch?

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index b9a493f66557..e56034abb3c2 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -306,4 +306,4 @@ from running test_progs will look like:
 
   test_xdpwall:FAIL:Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5? unexpected error: -4007
 
-__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d
+__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5

