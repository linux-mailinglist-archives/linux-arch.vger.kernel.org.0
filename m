Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6092621C6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgIHVQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIHVQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 17:16:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DAC061573
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 14:16:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o16so243071pjr.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2efFs7I/aVceVr/UA1FiVN+0BylwZxjeaszZFFD+TI8=;
        b=sITCjv2Gw9n5L/AbRCZ60B2tM96FOIAmZJP0xe2pWojsuA5XzhXqrZIsezZXCVNKFJ
         oTkLfrCwO3b29MBCWYBtrLpvexnpWu8O5O9PQPbfZcg2StDIQ5hvVUVYZF2KMkZQM3jA
         Y0n9t1cvTsIau5HLXC3w1BW386YBX5etGcBDupIed7NhVvmW3Sze/9BeRrY+3eebmC54
         A3rg+0Q2or5ANiemPjDYOHk9RJ87YkzEsypOP9ODMDA2xV0LR5EzXHAisx/02MWDtifr
         c59B02GuTqOPM7NTMhmOA+z/kS+V8qF7KI7GgYITYiOU1zTcJV35HGMVQ8GGwXhyPLWc
         L4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2efFs7I/aVceVr/UA1FiVN+0BylwZxjeaszZFFD+TI8=;
        b=GIMtMkY2oNQGfJkDX7sTYfyDOww9FskkFFyzVQNQ1nW4tCM4D7FITIeg6p80OuOhL7
         AC3IBpREt2K4CopcjiPs4pZmFFcPaL/ESjY13LfHxopYUCTcZIHdinR4IIab1XoG2E4A
         bXqYhPsfc/XKamKPopPutBE3QCdwJkLeJvRUCPcSxnd4iH4IEh/WVcYxEQJDKOnFEQ9F
         fNAfgUqqX12H1mIZPG1Q133DDVhVTlAWgWQzQg52XI/ryZPfkb+NKgCWk0/tml66WdIx
         xPPCXNX7RMMlOoR58SnH6JZzvW/91o6SeunHRGhgzCYkvlnNT8uPYDReKVf9BFz3qBEL
         Bhaw==
X-Gm-Message-State: AOAM5334OzO0elpKMLlhuD2goskXuRruutAi5IBYw8EyJJuThjnTLyk7
        GtsfTjgVqt7NYhsMgWcJTjQImA==
X-Google-Smtp-Source: ABdhPJyWG8mI3H/BsY+oT/o/ksZJ0zCieLkhk5hIgmn2bkbuRWqCNofmO6IoZa9/Ax5C5W1FdW8cWQ==
X-Received: by 2002:a17:90a:f486:: with SMTP id bx6mr641742pjb.130.1599599806032;
        Tue, 08 Sep 2020 14:16:46 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id 137sm315259pfu.149.2020.09.08.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:16:45 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:16:38 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 15/28] init: lto: ensure initcall ordering
Message-ID: <20200908211638.GC1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-16-samitolvanen@google.com>
 <202009031532.CD2A5F372D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031532.CD2A5F372D@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 03:40:31PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:40PM -0700, Sami Tolvanen wrote:
> > With LTO, the compiler doesn't necessarily obey the link order for
> > initcalls, and initcall variables need globally unique names to avoid
> > collisions at link time.
> > 
> > This change exports __KBUILD_MODNAME and adds the initcall_id() macro,
> > which uses it together with __COUNTER__ and __LINE__ to help ensure
> > these variables have unique names, and moves each variable to its own
> > section when LTO is enabled, so the correct order can be specified using
> > a linker script.
> > 
> > The generate_initcall_ordering.pl script uses nm to find initcalls from
> > the object files passed to the linker, and generates a linker script
> > that specifies the intended order. With LTO, the script is called in
> > link-vmlinux.sh.
> 
> I think I asked before about this being made unconditional, but the hit
> on final link time was noticeable. Am I remembering that right? If so,
> sure, let's keep it separate.

Yes, it was noticeable when compiling on systems with fewer CPU cores,
so I would prefer to keep it separate.

> > +## forks a child to process each file passed in the command line and collects
> > +## the results
> > +sub process_files {
> > +	my $index = 0;
> > +	my $njobs = get_online_processors();
> > +	my $select = IO::Select->new();
> > +
> > +	while (my $file = shift(@ARGV)) {
> > +		# fork a child process and read it's stdout
> > +		my $pid = open(my $fh, '-|');
> 
> /me makes noises about make -jN and the jobserver and not using all
> processors on a machine if we were asked nicely not to.
> 
> I wrote a jobserver aware tool for the documentation builds, but it's in
> python (scripts/jobserver-exec). Instead of reinventing that wheel (and
> in Perl), we could:
> 
> 1) ignore this problem and assume anyone using LTO is fine with using all CPUs
> 
> 2) implement a jobserver-aware Perl script to do this
> 
> 3) make Python a build dependency of CONFIG_LTO and re-use scripts/jobserver-exec

I'm fine with any of these options, although I'm not sure why anyone
would want to compile an LTO kernel without using all the available
cores... :)

Using jobserver-exec seems like the easiest option if we want to limit
the number of cores used here. Any preferences?

> >  # If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
> >  # .tmp_symversions.lds
> >  gen_symversions()
> > @@ -74,6 +84,9 @@ modpost_link()
> >  		--end-group"
> >  
> >  	if [ -n "${CONFIG_LTO_CLANG}" ]; then
> > +		gen_initcalls
> > +		lds="-T .tmp_initcalls.lds"
> 
> Oh, I think lds should be explicitly a "local" at the start of this
> function, perhaps back in the symversions patch that touches this?

It's already local, that part is just not visible in this patch.

Sami
