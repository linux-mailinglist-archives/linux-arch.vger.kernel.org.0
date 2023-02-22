Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F210E69FC59
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBVTji (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 14:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjBVTjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 14:39:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DD2B297
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 11:39:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so1320808pgt.12
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QuFwrfyGhsaio/b54BiON3hHx2x8fmq8wEZQ3LfunVE=;
        b=SU3DNWndMCC/1pJro+Heqmb+WEi36wWGpIE4iOLgiOczSpn488YzOMI1VKCBjVU3Pe
         9bQJhXRkvgHxJrh3+3SWzch5KC8p60SXHbviv7TSFEiOD8aKxqb69QwK1MjOMCmemnCV
         sYUahni4YES52JaKYgaDQ4gBj79URckPIw0sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuFwrfyGhsaio/b54BiON3hHx2x8fmq8wEZQ3LfunVE=;
        b=WSaiHx02NhZNZ1rX+RM+smbqF1aIUct12v6xxIOFs5RJKupPEmU8juck6pS+Ur0Pzv
         NuF+pliwpHmDRVHQcuH3rJNp8H4IekiO/TzBTxu3LtDC0Gc2WKsUr9Bu0bQOwhkutJCR
         Izy2E3bm85lIYq9MQzRbvAKIv6iT5zqKB43F1r3hm3RdNK+squSlV17a0ncm+6qJwJId
         PuT8eNKMtEVCYa3B6XdhhbGlL/ywRnoo63uohtahg3Vc+nYquKOHKf7MR5OX+G+Dow53
         MhNeB9bt3XA/HTW6nX6j10h9Y4fCsluNNfCtZJ8j8Fpg7vM0oo0UdKKo+DSZUKhXIrsC
         I1Uw==
X-Gm-Message-State: AO0yUKWVM5g80GTsSa6s6VSubC25WwucqpQQ55jcjmDmpkkZf4ByYth3
        eUgXVUQZqxsuCa7D/IISX9Wk7w==
X-Google-Smtp-Source: AK7set8nnFoA8bU2GM/UteuiQrgixkluyFqD0URUOP2mP5LchlNJwiKzugLbJ/Oa87xbg2R8v9UpjA==
X-Received: by 2002:a62:1a43:0:b0:5a8:2b95:badd with SMTP id a64-20020a621a43000000b005a82b95baddmr10071361pfa.33.1677094776242;
        Wed, 22 Feb 2023 11:39:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s25-20020a62e719000000b0059442ec49a2sm875653pfh.146.2023.02.22.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:39:35 -0800 (PST)
Message-ID: <63f66f77.620a0220.c6bd5.1fa9@mx.google.com>
X-Google-Original-Message-ID: <202302221139.@keescook>
Date:   Wed, 22 Feb 2023 11:39:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
References: <20230218211433.26859-15-rick.p.edgecombe@intel.com>
 <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
 <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
 <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
 <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
 <52f001ef-a409-4f33-f28f-02e806ef305a@redhat.com>
 <74b91f3e-17f7-6d89-a7d1-7373101bf8b7@intel.com>
 <62b48389-0e61-17da-6a72-d4a16e003352@redhat.com>
 <279E91DE-D152-4996-BBD2-BB310AD38620@kernel.org>
 <b09efb91-d41c-012e-7d99-fdbcf3e92661@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b09efb91-d41c-012e-7d99-fdbcf3e92661@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 09:54:36AM -0800, Dave Hansen wrote:
> On 2/22/23 09:42, Kees Cook wrote:
> > On February 22, 2023 9:27:35 AM PST, David Hildenbrand <david@redhat.com> wrote:
> >> On 22.02.23 18:23, Dave Hansen wrote:
> >>> On 2/22/23 01:05, David Hildenbrand wrote:
> >>>> This series wasn't in -next and we're in the merge window. Is the plan
> >>>> to still include it into this merge window?
> >>> No way.  It's 6.4 material at the earliest.
> >>>
> >>> I'm just saying to Rick not to worry _too_ much about earlier feedback
> >>> from me if folks have more recent review feedback.
> >> Great. So I hope we can get this into -next soon and that we'll only get non-earth-shattering feedback so this can land in 6.4.
> > Yes please. Who's going to take it? 😄
> 
> I'm more than happy to queue it in x86/mm.  I'll plan to queue Rick's
> next version that he posts and then we can do any fixes or minor changes
> on top of that.

That sounds lovely; thank you! :)

-- 
Kees Cook
