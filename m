Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621269C485
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 04:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBTDmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 22:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBTDmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 22:42:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4F76A3
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 19:42:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id fd29so962884pfb.4
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Re/3/CIaa6TLc9AUoK8DtIbP6WDJvTLErHxyMeEWQ0Q=;
        b=bUicfI6Ma3EQ14U6HkyUCUkMgBXWz0Jtu9LXzZBQq+jhzNVmyjEsHDEU99D5pJhVX6
         AOAaLuuBywKXLhjasaxR0PqhIiT3u/+umR9b3X8I7uqhjnllwC8TTipygr1UqBjF+6lu
         iypv9f/7GRPjFX61d/SP2lUFvQEUPpfhMjRlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re/3/CIaa6TLc9AUoK8DtIbP6WDJvTLErHxyMeEWQ0Q=;
        b=uu+dpnIgbkNpPjdsPToINWUklQWFZkaQdKsUOM1QVqnBCv/KFwMOSm6nup9aoMz6Vh
         uK45zTooNH4/dWwCzNgjtrq7Xb5XdkyYpzuV8cED0GFS+HgPU+39nK0UsRy9B2xyOnmB
         JdmEsASWTMLlS4b68kTs+f+J3YzMhJgRqlqRfasnZmLtbC5Y+k91YefSHB+bsqeZ1mrT
         Vgqe9p5z488f6BXiCXM7MyTfODnyHZ2N8x9ex4+zAK7eOUC8/WMz8HlzDnbUAo2ojmxc
         RvJocjtnp1hHW3XWRSV53SaXwmc1au16QIXAabnBh/QlJ+4OgfeoV1jmyOifPrv85ti6
         InEA==
X-Gm-Message-State: AO0yUKVwbCRf26UXc/NI7TrlnaUnRaGsPXu7lEW+f/DLpJZHJLZSIG0P
        WpXz6mI5IumOrh/EYALYGJIxgg==
X-Google-Smtp-Source: AK7set9ubhHzd0Qkpgz++VanVE9nN2ctikK/vAUG79ejzwTZpF5yu/FjqRddJiWdmGAc+LTQM3AO0A==
X-Received: by 2002:aa7:8f0e:0:b0:5a8:c2bb:f0c4 with SMTP id x14-20020aa78f0e000000b005a8c2bbf0c4mr1702839pfr.13.1676864539219;
        Sun, 19 Feb 2023 19:42:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b00575d1ba0ecfsm6571669pfn.133.2023.02.19.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 19:42:18 -0800 (PST)
Message-ID: <63f2ec1a.a70a0220.bb3e0.bb19@mx.google.com>
X-Google-Original-Message-ID: <202302191938.@keescook>
Date:   Sun, 19 Feb 2023 19:42:17 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:13:52PM -0800, Rick Edgecombe wrote:
> This series implements Shadow Stacks for userspace using x86's Control-flow 
> Enforcement Technology (CET). CET consists of two related security features: 
> shadow stacks and indirect branch tracking. This series implements just the 
> shadow stack part of this feature, and just for userspace.

Okay, I've done some bare metal testing, and it all looks happy. The
selftest passes, and I can can see the stack address mismatch get
detected if I explicitly rewrite the saved function pointer on the stack:

[INFO] Want normal flow
[INFO] Found 0x401890 @ 0x7fff47cf2ef8
[INFO] Normal execution flow
[INFO] Want to redirect
[INFO] Found 0x401890 @ 0x7fff47cf2ef8
[INFO] Hijacked execution flow
[INFO] Enabling shadow stack
[INFO] Want to redirect
[INFO] Found 0x401890 @ 0x7fff47cf2ef8
Segmentation fault (core dumped)

Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
