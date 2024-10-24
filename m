Return-Path: <linux-arch+bounces-8528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970619AF393
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DC81F22924
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6F51AD3E5;
	Thu, 24 Oct 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKWqUJrS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A813184101;
	Thu, 24 Oct 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801295; cv=none; b=MIhgXThPCj6/1lSyEDmmWcQMxenCrrfdURR+Es6JsLxk6nuwJ6aXwh2VP0hCShlIgox03YBzZ9eEbfHO/CnKJCwNMOoGipOapEykpNu9ed+aXzwzZ3mUBq2T/WJDEbJW9NpTShnGLKe2LUwdg7FJHcIi4H1CLqOqZasb+QFk3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801295; c=relaxed/simple;
	bh=RI8YS+uvg/qHub00mkdvWpCj6/uZUUM7Tt05ZynxN24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYmBlAlqETAEnsXp6f1Nd9idEYK94JIW+BKLWnk+Z5Eb8SUy/KU4j+X0nKfpkYEWR1mnxehCjo+xLjrdt8an+8LrtqG/Ic259CQiwJsROTH1pnS3OVFWYb4QZiXSBi971msOr0cCTaqwy2IxAnH5XIPgH+8LFRy5B7zPEgnHBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKWqUJrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA25C4CEC7;
	Thu, 24 Oct 2024 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729801295;
	bh=RI8YS+uvg/qHub00mkdvWpCj6/uZUUM7Tt05ZynxN24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKWqUJrSM6Ii/Rgk2s0A0A/8FsLXOTIYxiEWl3+3HYMDYwFrghZ5u7OsAL1n6L1mN
	 qD8WRO8Fad3cA9pnK8TOIqJWad+QPkBHrftWldraX0PrRU/CDOyirruOs18Bu5JzHC
	 3lnUjSAor3kfgvjev7X/hx0Uj9MjV9XeWv4GA1OsLZ9NyKaK6FChbZpVrcGCvp8MLo
	 9AqavICpVfR6qfxAWF/M3HYbIKLsl6bEiKu7YitaIpYnKPG54+sRNjMwGABFzfDHGD
	 wiP9/JdFkDyWNhBtjRAEOT2P4wZNiDTDMmIvaUxzGEEh0/VtVSJHltZwuCsX7AFa9m
	 pCllT2LysCfKw==
Date: Thu, 24 Oct 2024 13:21:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
	masahiroy@kernel.org, deller@gmx.de, linux-arch@vger.kernel.org,
	live-patching@vger.kernel.org, kris.van.hees@oracle.com
Subject: Re: [PATCH v3] selftests: add new kallsyms selftests
Message-ID: <ZxqsTO0BAQLPJDJL@bombadil.infradead.org>
References: <20241021193310.2014131-1-mcgrof@kernel.org>
 <368aa911-7a88-4a00-8830-4a183fd6f352@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368aa911-7a88-4a00-8830-4a183fd6f352@quicinc.com>

On Wed, Oct 23, 2024 at 10:28:49AM -0700, Jeff Johnson wrote:
> On 10/21/24 12:33, Luis Chamberlain wrote:
> ...
> > +gen_template_module_exit()
> > +{
> > +	cat <<____END_MODULE
> > +static int __init auto_test_module_init(void)
> > +{
> > +	return auto_runtime_test();
> > +}
> > +module_init(auto_test_module_init);
> > +
> > +static void __exit auto_test_module_exit(void)
> > +{
> > +}
> > +module_exit(auto_test_module_exit);
> > +
> > +MODULE_AUTHOR("Luis Chamberlain <mcgrof@kernel.org>");
> > +MODULE_LICENSE("GPL");
> > +____END_MODULE
> > +}
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=1. Is that a concern here?
> Should we add a MODULE_DESCRIPTION()?

News to me, I'll send a follup patch with just that alone as I already
merged this onto modules-next.

  Luis

