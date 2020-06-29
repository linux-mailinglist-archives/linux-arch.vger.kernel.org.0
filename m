Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82D320D7D8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbgF2TdT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgF2Tco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:32:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E64C0307AD;
        Mon, 29 Jun 2020 08:54:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c30so11812501qka.10;
        Mon, 29 Jun 2020 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJxCpiw45uiFCKFF/Aa3ZwVBKPmiXfb3oRMSPK0K9jk=;
        b=BZU/9VIc2Y6E9fhw3s/Nvu9omCHAjFS6JaJV5N4AxmLYc8SJERh++jMh8hnkBkk5Rj
         nj3dy4P+rSnq/nKutiHVABK5OvmhyQTpqlnRoybjbMehxbS3dchjXD/bXVVgiUic9uiX
         9KEIZ9SFZNWU1A1IkKVOam+79epkd7faiaeumhjdsOfstN/OVNInEuKXfKQx/sEHHahv
         RB+f8/hLrG2qOALMJ24yNYyH+tfgwNzIZCerrom8AQJZpijMe2n8a1SdwL5fPMpUqUXp
         m3eWJnS1YrcNRqYOxz41DsFZ6fzDkWK87qnOzwnDRL2z6um5+Tphb3hwxdh4ZFbHTXGn
         PBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aJxCpiw45uiFCKFF/Aa3ZwVBKPmiXfb3oRMSPK0K9jk=;
        b=O9/E2OtiXV98xAPz8iP+4nhN496omKmdK/qPb/ff+/UeCD9HW2E2PeD335lFT9q7IL
         /0y3zcTGXlFdR+IZiMF8WGdOvCyL2Axpmi/uRE4eQVTdocDz9BUKcOoZmVtvkJtvgT0a
         juAbkhRCW8dBASFE+lN2rYlNOY0hvvmuizoM5WGs96/tNnvQqLTtcHH7/wlR03vuOLm/
         Lk6T0tOBLq7Ja0L/j+4i7LY8Giqyq6slIbzVhkLPzQhAMFYyGLxQnWnU32y/wYZ8G5Zm
         1Xe2L6/pDeXArWHcwWkyrGV5MVHJIVcjSABtM7p0Hjv8z3n6HOo7444i1IyiZRLr5A6p
         UsIA==
X-Gm-Message-State: AOAM530/VDNixSidB90UlbtTb5L4Oc5o7lVq85ImQWw4Fxb48SUvMk/5
        6m2j1b4sVtEY2aWNwvUNevM=
X-Google-Smtp-Source: ABdhPJxwuEkyqc0Vgw+drYJAZii7afEIejnAVDgmQdUScCrDEFtKnUdsKQel/JRcOrIWioge2a+zKQ==
X-Received: by 2002:a05:620a:c08:: with SMTP id l8mr15224938qki.239.1593446044131;
        Mon, 29 Jun 2020 08:54:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l46sm81965qtf.7.2020.06.29.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:54:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 11:54:01 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Message-ID: <20200629155401.GB900899@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629061840.4065483-15-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
> 
> Specifically, this would have made a recently fixed bug very obvious:
> 
> ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> 
> Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> 
> Add missing text stub sections .vfp11_veneer and .v4_bx.
> 
> Add debug sections explicitly.
> 
> Finally enable orphan section warning.

This is unrelated to this patch as such, but I noticed that ARM32/64 places
the .got section inside .text -- is that expected on ARM?
