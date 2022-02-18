Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2994BC0FA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 21:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiBRUIi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 15:08:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiBRUIg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 15:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCEFE24B2A0
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645214896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbD0qiU4RjhqV726jofvBeaOVqKh7JjTJAB5iz2l93M=;
        b=cA7EwE5OdFiTLj2JF3mjF4lI6iI+z3lsffT4McmY3J3L3ZtEAJ3UrMQ8iv6sz+qdHsQ8qz
        30mp4oi3Pcxr1W2A4iM/+nUzrTY/KIaOOpbqkrkLywNuMpfZqgzBQpt38FoSyXtmly/gPF
        cB4ISfdUG4W9MIusrvPBxFyUN396AVk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-VZGxcR9BO7yideQSkiMLOg-1; Fri, 18 Feb 2022 15:08:15 -0500
X-MC-Unique: VZGxcR9BO7yideQSkiMLOg-1
Received: by mail-qk1-f199.google.com with SMTP id 199-20020a3703d0000000b005f17c5b0356so5051786qkd.16
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 12:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbD0qiU4RjhqV726jofvBeaOVqKh7JjTJAB5iz2l93M=;
        b=sp/HR6YF/F6O7k0iBBzHj22zbPihk8A+10xhkW31ySgJHEsIqN+jsyNT8ZJ3mhsHlE
         4DLNiywC7fZNxUi8UswbNg2CMJNl+NcWo9zso0mwZ6wCHuYU41pjbo5Yk2LUvtW7cgzh
         Z9azieadSzT1rzWIvKnHE9nnQvplHGLTDYqGT7qYPzSa+Neehb6c0ujAFHIDismDcE35
         IiXbsz12e2+XWT54BxQmjIVM4UbtEJpqgoGxG6t87/sM1dbyMfiCOWXTsI5tHOvnwBCf
         iusZL8AHocDtBmsgrQ4BSTG9SfmSe6XKlaX76gI4X1+oKYWVJPd6XDMTcGJmh9qocmjI
         jcHg==
X-Gm-Message-State: AOAM5324yTKL2ffIvNt6bMnl8SKeFg3joQNcR++FRbDxPHccHqAfvbYc
        sj/dHyuVgjNQwo1zO85ZdbM4rPTX8UW2buIpHWYJQTeNGjeXdvFhJsd0dwELKEytFaUC645wOp4
        d9CJ1NNFTTahe9x9fUN2+1g==
X-Received: by 2002:a05:6214:17c2:b0:42c:b915:69f with SMTP id cu2-20020a05621417c200b0042cb915069fmr7009999qvb.95.1645214894992;
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyES3jxSXm6PUQSrWkCWkJOx1aXkyiFLiwQrMEdx8mKix/Dv/YjSGuwkSGrstdFEaba1AKRqg==
X-Received: by 2002:a05:6214:17c2:b0:42c:b915:69f with SMTP id cu2-20020a05621417c200b0042cb915069fmr7009947qvb.95.1645214894772;
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e64sm6288522qkd.122.2022.02.18.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
Date:   Fri, 18 Feb 2022 12:08:08 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
Message-ID: <20220218200808.juxnoidtxa7fjsk7@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
 <alpine.LSU.2.21.2202161606430.1475@pobox.suse.cz>
 <20220218163111.98564-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218163111.98564-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 18, 2022 at 05:31:11PM +0100, Alexander Lobakin wrote:
> it took 2 minutes to generate the whole map (instead of a split
> second) (on 64-core CPU, but I guess nm runs in one thread).
> I guess it can be optimized? I'm no a binutils master (will take a
> look after sending this), is there a way to do it manually skipping
> this nm lag or maybe make nm emit filenames without such delays?

Hm, yeah, adding 2 minutes to the link time isn't going to fly ;-)  It
probably takes a while to parse all the DWARF.

Based on ther other discussions I think just using the basename (main.o)
in STT_FILE would be good enough.  Some duplicates are probably ok.

-- 
Josh

