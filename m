Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90F5F35A8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJCSbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJCSbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:31:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF9142AE5
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 11:31:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16059458pjq.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gcdwOpvyFJSGp4cQvt0W+LFd65h9zHXN/GY/Jg8dWAM=;
        b=gJcwrq+sWxdvlCByPEOgZOCHihrWoRmnR3mww8TjthJtRRBcDm1NOT8dEfj3zPwl3/
         HsdezaDoUscXjGWYZVZZ9e1w0MI/oGshiG0yfh4722czmPMYeZ/UHIobQ1i9UPyF8U9H
         nSm1o41vrdbF+umzuEpQcD26W6+yGj/rzsQX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gcdwOpvyFJSGp4cQvt0W+LFd65h9zHXN/GY/Jg8dWAM=;
        b=dj6HlSSJXJnKG/hmjpCZTbVn8J7NTFyvcN/xWfDpESi3ml2bszjhhQVh9FAMMh6Ulq
         N4B411XQv4tg0oRV5xstdhGpRhQq4c/5uldKGtPcCqOrSG+XqGR6dcaml8K2rqYJKXP7
         Fl7lbDAxAyG/GZcIdkmXhondpWSNFA33I+HxaXdkOfGEs5DuBtfB3ACINTFzmGWg4cIA
         dqBGmQcTyVVFBKtF8/oSIeoA7eFJ8P1uCdphAHQlMol3yFOmWyJdBxUWlBc4B7EcFRBF
         VDupH6jD6mYLa7HWLGK9uJCh3l0DUinf7QQb9fooUmHOFjysy8Kt8LJrZGcN6uDDgNp6
         7AtQ==
X-Gm-Message-State: ACrzQf3IfA6EcqaGizPUWVCNlJ6LBX1xw/oh1r+f79fIUC4YUjW0+4w7
        pVyw0ueVMlBi1nwS5jfXRmmHMw==
X-Google-Smtp-Source: AMsMyM7us4SWa4jI1WB82zn6GmkmuiTqVFRkDe9ir2Snt5g+VtLsgwjxcWuAujRu8O7s3VwmMifIGw==
X-Received: by 2002:a17:90b:1c12:b0:200:b623:455d with SMTP id oc18-20020a17090b1c1200b00200b623455dmr13305214pjb.88.1664821892754;
        Mon, 03 Oct 2022 11:31:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b0016dbaf3ff2esm4262285plb.22.2022.10.03.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:31:32 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:31:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 19/39] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <202210031131.AC6CF1AB@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-20-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-20-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:16PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Account shadow stack pages to stack memory.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
