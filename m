Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71D83FFA0E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 07:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhICF4r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 01:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235858AbhICF4r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2021 01:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=MgAVpRD73pk/8lzcW+DoNeFbL133ALWIsVv/se/2fJfovYIk1jr85DGjEpv2f7mRu4/G20
        4Vvl8KFwUBfSL7T4yvLoVhp38FP0tc6nnPt2cwcCA1wpIqEgHQ52v6tifbiGvBtAUPWZaO
        SiQBohye4M7Lt4pPUReecl3BlheLtzc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-se_NVAIcPHWaOHDy9FVrxQ-1; Fri, 03 Sep 2021 01:55:46 -0400
X-MC-Unique: se_NVAIcPHWaOHDy9FVrxQ-1
Received: by mail-qk1-f197.google.com with SMTP id h135-20020a379e8d000000b003f64b0f4865so5255189qke.12
        for <linux-arch@vger.kernel.org>; Thu, 02 Sep 2021 22:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=T9UVJpi8VCM9b5JArg8yOrrD0jKcHO3ErAjLvd0TlJd8a/fWLLsGzqKua3CWS/WlG/
         +HCGFhBV8rcHS+CAcDvvr8KOdB63eSHNWFjO0ISmfe0IBjpz+J97D9S7KSTnc3+22HFA
         m0w/oH5XElGkCSqAulu6R/3ftTbo54XRfKQk4vbkl/kMLnbhMXSRYrCweyfbRJtMnPfA
         60ETo4Bvxji+uzKlr1IPCmWRQitxS7Ld5FXbXjRwXfoqPn14DXHn+mvpcu3tuWLr1qBF
         Ke/XuDq7w0SB3YClgt7hRDU+3d4ksklfP1cK7QqprALEjnAMcaSOClAvnVsos4VUQ14m
         hHzg==
X-Gm-Message-State: AOAM531sJPYsM6G4eNh8LbE594jXtDsh2vXybQP/+ZA8RPDz52wat0UO
        PPT8+HfOSh6Eb4cpv56766ILj49jAkCXTcTx1EmSDO9aGUPjzQQCw+iG9y3++UGqudqFNfYwT3A
        O3f4MCxEnt789NjjE9SRolA==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967395qvw.16.1630648545823;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2rfokB35RHoytkOenvkXEQNhy0zoJ+Ni5jGU5Fpr4Gqpd31z62no5fBtGg9o+rq+iUgaKgw==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967372qvw.16.1630648545652;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x23sm3180733qkn.29.2021.09.02.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] vmlinux.lds.h: Split .static_call_sites from
 .static_call_tramp_key
Message-ID: <20210903055541.b3dk5yqwkslklvsa@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:55PM -0700, Kees Cook wrote:
> These two sections are ro_after_init and .rodata respectively. While
> they will ultimately become read-only, there's no reason to confuse
> their macro names.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

