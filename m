Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B374D13A6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 10:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbiCHJq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 04:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiCHJq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 04:46:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FE3E5C9
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 01:45:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ACDBB81810
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 09:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11416C340EC;
        Tue,  8 Mar 2022 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646732728;
        bh=iotVYzC96pnctOSwfHjiP/LZc5bmukNkEwD4I7skqws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYdsDQO19ZsfpxsJzU9IbHSkiCYxEI+46imI2pk0F8sGhdGj31bdBMnqmjwx+vjra
         7evH2Jlya1+eNkgMkUj1VoQghXUaHHGnNgkMiRIaIseGpMQJ7krh5eDj4SNMsKpMfA
         W8Gy595ceZPJTZEkIHd345HRcRfAFCFrnFJ+lnjiOt9vOkAWx30FZ3LcPJ2jGrwXWJ
         lrzlUoW1L2S2w0OKnIM2GKML9B4ENo250KxUDepB5KWOpX9cveOx+zClbkgEEZ4MiZ
         ZsbEEEBRf86styeCwhwwtpSzMo1ljOZNkWSPJllDpSkoZ5lDgROB63v1PMShmJQyBZ
         Ayfh3exaIkkaA==
Date:   Tue, 8 Mar 2022 09:45:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v10 1/2] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <20220308094521.GA31063@willie-the-truck>
References: <20220228130606.1070960-1-broonie@kernel.org>
 <20220228130606.1070960-2-broonie@kernel.org>
 <202203071551.DBABE01@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203071551.DBABE01@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 07, 2022 at 04:00:15PM -0800, Kees Cook wrote:
> On Mon, Feb 28, 2022 at 01:06:05PM +0000, Mark Brown wrote:
> > Currently the ELF code only attempts to parse properties on the image
> > that will start execution, either the interpreter or for statically linked
> > executables the main executable. The expectation is that any property
> > handling for the main executable will be done by the interpreter. This is
> > a bit inconsistent since we do map the executable and is causing problems
> > for the arm64 BTI support when used in conjunction with systemd's use of
> > seccomp to implement MemoryDenyWriteExecute which stops the dynamic linker
> > adjusting the permissions of executable segments.
> > 
> > Allow architectures to handle properties for both the dynamic linker and
> > main executable, adjusting arch_parse_elf_properties() to have a new
> > flag is_interp flag as with arch_elf_adjust_prot() and calling it for
> > both the main executable and any intepreter.
> > 
> > The user of this code, arm64, is adapted to ensure that there is no
> > functional change.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/elf.h |  3 ++-
> >  fs/binfmt_elf.c              | 32 +++++++++++++++++++++++---------
> >  include/linux/elf.h          |  4 +++-
> >  3 files changed, 28 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > index 97932fbf973d..5cc002376abe 100644
> > --- a/arch/arm64/include/asm/elf.h
> > +++ b/arch/arm64/include/asm/elf.h
> > @@ -259,6 +259,7 @@ struct arch_elf_state {
> >  
> >  static inline int arch_parse_elf_property(u32 type, const void *data,
> >  					  size_t datasz, bool compat,
> > +					  bool has_interp, bool is_interp,
> >  					  struct arch_elf_state *arch)
> 
> Adding more and more args to a functions like this gives me the sense
> that some kind of argument structure is needed.
> 
> Once I get enough unit testing written in here, I'm hoping to refactor
> a bunch of this. To the future! :)
> 
> > @@ -828,6 +832,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	unsigned long error;
> >  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> >  	struct elf_phdr *elf_property_phdata = NULL;
> > +	struct elf_phdr *interp_elf_property_phdata = NULL;
> >  	unsigned long elf_bss, elf_brk;
> >  	int bss_prot = 0;
> >  	int retval, i;
> > @@ -865,6 +870,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> >  		char *elf_interpreter;
> >  
> > +		if (interpreter && elf_property_phdata)
> > +			break;
> > +
> 
> This is not okay. This introduces a memory resource leak for malicious
> ELF files with multiple INTERP headers.
> 
> >  		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
> >  			elf_property_phdata = elf_ppnt;
> >  			continue;
> > @@ -919,7 +927,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		if (retval < 0)
> >  			goto out_free_dentry;
> >  
> > -		break;
> > +		continue;
> 
> Because of this.
> 
> As a fix, I'd expect the PT_INTERP test to be updated:
> 
>                 if (interpreter || elf_ppnt->p_type != PT_INTERP)
>                         continue;

Thanks, Kees. I'll drop this branch from -next until it's been resolved.

Will
