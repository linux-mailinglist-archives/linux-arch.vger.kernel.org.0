Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CD606BBF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 00:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJTW50 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 18:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTW5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 18:57:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEF22E0DD
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 15:57:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l4so655232plb.8
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMshH9biaVXQs7+fRI1qPbg8/Vmgf41zzdE8Ax9DFYA=;
        b=UxXF8cbs/icsMsb/bPq8qttNDmiXRbLXaFp21el0sK2dq1lWLpxMZFArsRK0mkWhEU
         yH4Std6R7RGYgzqSZ9NFNY44SR/8k2wJ6QyM+mBSFV9D+hNdowYlrtXHMJQwwC6UoW6B
         hzj2LHb7fOguUuRiCYaSJ8vUl7YrNcGUVd+Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMshH9biaVXQs7+fRI1qPbg8/Vmgf41zzdE8Ax9DFYA=;
        b=dQ6IKSjgr7cvymtFL06ebgL7sAMcg0hN7CtXbqgndEB9cHjPOMDmnXHt3yikh6/UqC
         GsjSrqzurFqLOGEHtVrK/oGmDNBFQ2GQ5XyYsShk1dYDxNNNPqKlCCtf5wLUeKtnjLZd
         7Bd4kUVpsQuVkOl7aE1X5pMVFj7Wldfg3ieQzc9w/qBKxmUnROQ0mhe9t6x1JzfC8Jl1
         xhFaHW8kZdJymuNkbIQbWsmWX+qjezrH/FKmEwtL0rc9MvVEDUY3GGAurDGJ1DJSOvTr
         A3p+hB8ehBfVL3FQpn1PKDOnSaOZZvKIQaNurJRGK+3j5XTf9QgdTdDxA3/lFRWRXtoI
         5QkQ==
X-Gm-Message-State: ACrzQf2twf9vcQNRlo6TNHtBb56HVVj4rE4m0svEQQSDAw/jFSgI7nu7
        4RX+v0QT770iWS4Qu0KRFHOl3w==
X-Google-Smtp-Source: AMsMyM5lZ4Dia253exhcKwnxHFmBcVrokulHdGNf45q/7BqKwj7LyyrZSMwZCU9ocNupwEMC8xBjeQ==
X-Received: by 2002:a17:902:b708:b0:184:3921:df30 with SMTP id d8-20020a170902b70800b001843921df30mr16498236pls.43.1666306642632;
        Thu, 20 Oct 2022 15:57:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00176dc67df44sm3361025plb.132.2022.10.20.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:57:21 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:57:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 27/39] x86/cet/shstk: Handle signals for shadow stack
Message-ID: <202210201556.EF52D322@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-28-rick.p.edgecombe@intel.com>
 <202210031347.6DBE61199@keescook>
 <56095eac64e95b79ea04e84909d8ba0ab49d9246.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56095eac64e95b79ea04e84909d8ba0ab49d9246.camel@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 10:08:17PM +0000, Edgecombe, Rick P wrote:
> Kees, sorry for the delayed response. There was so much feedback, I
> missed responding to some.

No worries! Most of my feedback was just to get help filling gaps in my
understanding. :) I appreciate the replies -- I'm looking forward to v3!

-- 
Kees Cook
