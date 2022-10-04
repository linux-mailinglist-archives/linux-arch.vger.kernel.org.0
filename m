Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4C5F3A43
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJDAAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJDAA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:00:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0744915FEE
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 17:00:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so11581744pfh.6
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=o2b6tkTm79Hq7cBFTASISNpumWfJdTPRV3REM28Za+c=;
        b=RHkLlXama069cxi74bxt00Ik3yKbCp7eqcjpJ+BrwE/1Guzo7yRXeE2Mlwg9/Q1pft
         FpU8rWJ0zhvXTgdtu5ZrT9wcAMy8omqjXqtd+QnQLb72g+yiqjNZwXumr+AvRy9LNXuJ
         PhYt7Z/apm2VoEc6VJGKm4Os53iN72KHY4TqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=o2b6tkTm79Hq7cBFTASISNpumWfJdTPRV3REM28Za+c=;
        b=JW1SrYumJ220aAwXfvzFrT89VloMh+ekOOy+g2UdXjscpQShkoDAX8zyVJV8TBD+MF
         3KvSXj6TOZKHF0Z2BJ2fZucbA08Wrvuw0FG6vzXNWUo4ccOUGbq/0zxuVKhhqhwE/hNW
         2sBNrYDdKIidrCyy242rgoDQAvL+6cYnaoTXbYKgI9eeFTfaLAK7c3Oz1RyLR5gSnQuC
         Ks7X5hc2iL6/nkQX8hmDEmReW/HTU5ufZHt/31IdCOYD9HsGY8WAfZb93aN1jPcCnvLk
         4vrTTxkLQYBW3LMQwN4mztNxkNTj5rf2GCLsC572ct4S+/Kh7mPsJrATASpML2UquwBZ
         Pm7Q==
X-Gm-Message-State: ACrzQf0YtcdzwW2B2QK8qeEZ3aa8SZ/C/IeyvSPLGPnQTTeUJ1ixAqXQ
        ZSMEVN95WbCzo3BdLd27sQt12g==
X-Google-Smtp-Source: AMsMyM4XTe6Addd3B3fzFGMr8MXv7g/1myw41iKI39g5lf9c2CLcuvJt36Ijei3dGll/IC1/xnbqFA==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr20651434pgm.29.1664841624524;
        Mon, 03 Oct 2022 17:00:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b00178ac4e70dcsm7787131plg.185.2022.10.03.17.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:00:23 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:00:23 -0700
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [OPTIONAL/RFC v2 38/39] x86/cet/shstk: Add ARCH_CET_UNLOCK
Message-ID: <202210031700.3C9BB219A@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-39-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-39-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:35PM -0700, Rick Edgecombe wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Userspace loaders may lock features before a CRIU restore operation has
> the chance to set them to whatever state is required by the process
> being restored. Allow a way for CRIU to unlock features. Add it as an
> arch_prctl() like the other CET operations, but restrict it being called
> by the ptrace arch_pctl() interface.

Hrm, please make this build-depend on CRIU...

-- 
Kees Cook
