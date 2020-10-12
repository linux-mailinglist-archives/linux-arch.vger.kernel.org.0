Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2928C14D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgJLTPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgJLTPQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 15:15:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EDC0613D0;
        Mon, 12 Oct 2020 12:15:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so1531115ljj.0;
        Mon, 12 Oct 2020 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HoEgSi7W4gHD9lScysoMmzA283msUCELsQqu811nuNc=;
        b=Ql1melcRhvWByESFg5O9z6kB9ZaejNEcoZdrPtWcHm5Eb+e5dEy98OHoHK4KMI2qvs
         BQbhmbBhTukGkR6Q48H5ZM27KZKnMeP2hVXC0TSoA+qQvkm9o8wE/+LF1rVnj/ar4xAF
         Qror7GlA7bJ2bzmz2QWfUBs8yBTTNxkCL0HpPmUzKqOhaDoa6qRTCjs8xGcriqroLZAR
         V76TOINy7/Wulmj/k/4QrmvLbA9NzyHoH/vyZUqRMQ8pMYwL1LPGHQswhd0jwVv+3eSy
         bVo9G1b4xp9hb1TemZo1b/eBszcC0Kc+o3gaCGKztpcU+AG/e+dFRg+PlwYmkACn1S5I
         Tc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HoEgSi7W4gHD9lScysoMmzA283msUCELsQqu811nuNc=;
        b=aXSorLj5P5Qttjb+8kuZec5RXrWs7tpcmpze1LHcSvgQA3vmcsKdbwv3ICpGzzMOpU
         3gFGTXfi7g3Qw0+6AZ86DdpcBs5sNZWReopECJQrfpR7lFj3OI9Q945TlCGbK0IkwJ56
         Dxr4XMcRJKrIVwApcTRTasT8+vhvCVf/JYTisnxLFxXqrH6SSp6HtPRy+df8Io58PnYL
         J2Gev2CMqubZX4r++Hu8kScE9ndXojGRqMifxDeCa1cFQrRhC+7MXQiQBI9NovGDJL9N
         a7TFITLXHxsrBB/26mYuLdhAA6Yd8t65h5cvSFAPqA/R3341bXvtcni2E9OXNrZZBokT
         r7Uw==
X-Gm-Message-State: AOAM531YOwRbKrJJCPWvXnjSys2ZQNXfsPAappc5QDMBbUpWgwBDX0aO
        LYIpbZGG79zfV/34xqvezyI=
X-Google-Smtp-Source: ABdhPJyunP+sr/B3JWabN71d6meVGuLl7M/RSAPI9eowpJdSxaoXQ/4ExdCfDtrOaJiRLT2GklJNOQ==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr3102963ljn.126.1602530114236;
        Mon, 12 Oct 2020 12:15:14 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id q27sm1092814lfd.261.2020.10.12.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:15:13 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 0C3381A032A; Mon, 12 Oct 2020 22:15:11 +0300 (MSK)
Date:   Mon, 12 Oct 2020 22:15:11 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v14 1/7] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
Message-ID: <20201012191511.GC14048@grain>
References: <20201012154530.28382-1-yu-cheng.yu@intel.com>
 <20201012154530.28382-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012154530.28382-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 08:45:24AM -0700, Yu-cheng Yu wrote:
...
> +	  the application support it.  When this feature is enabled,
> +	  legacy non-IBT applications continue to work, but without
> +	  IBT protection.
> +	  Support for this feature is only known to be present on
> +	  processors released in 2020 or later.  CET features are also
> +	  known to increase kernel text size by 3.7 KB.

It seems the last sentence is redundant - new features always bloat
the kernel code and precise size may differ depending on compiler
and options. Surely this can be patched on top.
