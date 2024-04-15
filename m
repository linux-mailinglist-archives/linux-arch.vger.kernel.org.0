Return-Path: <linux-arch+bounces-3715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F638A5B6E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7441F2127F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705CA15AAB7;
	Mon, 15 Apr 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X68uGwjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB715696C;
	Mon, 15 Apr 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210071; cv=none; b=NvgDl23RCcbrfe2sCf6w4Hao6JnPR2H2P9snncy1GnOvvGTbCFVIN5hamEXb3sLeJJfRzUEFMnmm/MdWLGO3m6/0AWaAt46Txhs+LQs751ouB0RzuKuGN1rqc+G3dEiy5f55isVqejZRhSKFqN0NcQxQrCHldBI6c+sWU6ZpyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210071; c=relaxed/simple;
	bh=c88aT9uSkW8Wa6uVyZD8LuIy0fX3f9Ky0S7uWq9mvQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlUIP1wqu8feqIFVpgt0jvBqsitewTz7HB06cSv4lXpKLVqlz8DbWUigBG6RPixgz1c0fEqIAg3xFgDyS5kZ0h3VWsVrRLZk3KHOf4yMLPNc2TAEd6KvS7zVobXDLQu5WUui5vA2BFDf6KvJjdStuKdZr6XjIWOMxoHLHFC0QOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X68uGwjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF39C113CC;
	Mon, 15 Apr 2024 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210070;
	bh=c88aT9uSkW8Wa6uVyZD8LuIy0fX3f9Ky0S7uWq9mvQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X68uGwjXzKz0fwXuVWglnVmtjb8qUFt0+9nP0i3Fh6inoupbLbEmeOsUeFr3Vlyu2
	 /rIaj/7xrtoELSRzrikvjHJzvBXG6Y0HGwvmfuE8JXG3fGbyUYJTw1FDlbQqif2rxr
	 rdSfVD5LsKfQK86tKtHslMvJYmCdmnsksFWx63JIrpnCmpecx7GDTRe3gLBp2VKi48
	 9pLugPwYPPZ6eJW1sqZaeTR0lBloo9rgt4RPccFBTdgwa5NybNYw0HIr0aBbC1D15J
	 3dxw/0B9HIOAgdH6EbCtVKWNmmscw0jRSf+0Vu81xEUZgT9DHFqiVH8eyesDjtrHwa
	 ycgl8QvkK1BnA==
Date: Mon, 15 Apr 2024 14:41:05 -0500
From: Rob Herring <robh@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org,
	andy.chiu@sifive.com, jerry.shih@sifive.com,
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, charlie@rivosinc.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <20240415194105.GA94432-robh@kernel.org>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>

On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
> On Wed, Apr 10, 2024 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
> > > Make an entry for cfi extensions in extensions.yaml.
> > >
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > ---
> > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index 63d81dc895e5..45b87ad6cc1c 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -317,6 +317,16 @@ properties:
> > >              The standard Zicboz extension for cache-block zeroing as ratified
> > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> > >
> > > +        - const: zicfilp
> > > +          description:
> > > +            The standard Zicfilp extension for enforcing forward edge control-flow
> > > +            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
> >
> > Does in public review mean the commit sha is going to change?
> >
> 
> Less likely. Next step after public review is to gather comments from
> public review.
> If something is really pressing and needs to be addressed, then yes
> this will change.
> Else this gets ratified as it is.

If the commit sha can change, then it is useless. What's the guarantee 
someone is going to remember to update it if it changes?

Rob

