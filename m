Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC364483198
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 14:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiACNxp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiACNxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 08:53:44 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C723C061784
        for <linux-arch@vger.kernel.org>; Mon,  3 Jan 2022 05:53:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h15so42493491ljh.12
        for <linux-arch@vger.kernel.org>; Mon, 03 Jan 2022 05:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MTSM0tUGvNPWHNroYDrMPHJ8+MECxnNO9mRPQwxLmc=;
        b=00uAyDZtYRScRscyI8ZuMA/kYZ63Szx7eQk1dv4Y6C3AZcdesqT277Cw/mRscCh2ed
         l5oQlQLYFEWMPCA8EWiSix08hxah9GOyqn9TwMcbnu6vrs5RIbXWmrWcijs3/LEK/7ZA
         u5a0k2oe5MjqwGQaFLQpT4HN6KDmjx6Yn6/8FzAnhn0IZkTJQxB21TdPADYn3ZEDFRFp
         QnlmoMSEdv+G6jEQTurSWUMJNfrfJYf8R/IO8rSkzIAwLUI2e2aMiK4NE/PryBOfhPYE
         bjU2+fYXyiXdTiRxexQatobAjtLo+JpbPkg3bnM22i+H/MBRUx4N3/Pp/OG2VIyPmVCj
         kYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MTSM0tUGvNPWHNroYDrMPHJ8+MECxnNO9mRPQwxLmc=;
        b=RLyaRS+SoOJOzO7G7tuAcQWWJW8fvLWNJ2pv9AtL7vmrFOEYUSjuB/q9TohMsFc3g8
         Vo8XflCJSruDIWfejlgHDbheAslvdrwBBOge3U+rXKjOaMBJdO3R7mXmMfNr7EvB3Smm
         yY0/tTfin5W+zRVdJH5a19xcPBq90wUldCMYWM4IzlkFiiLzzcCd04q6fef3UElbIiVb
         o3VdTNs3C9iLhmaspVwl4IG0djTGF8isQyf7LAFzBU4xULNA8tSjCnLPe9lKygf0NPZp
         uhVV+pzm8swRXDCLneHPxwzUfth0rvxCK2oyn4Y3YpDGwbvK9RH2M1K1Izws5u/8juh6
         obng==
X-Gm-Message-State: AOAM531A4ZocpwcCl5brwj7BxHFKEr+vFwsHnob15F/c43tMxKdg77Fa
        et5LxoCmyQGuiWuOuqBEsHSp5g==
X-Google-Smtp-Source: ABdhPJxqygORPBLOI6WnWvHPQloq/mJxVbJDAReb+F0fiB99BHp6nev1baIgrPJcX3YbI5wPds9lUA==
X-Received: by 2002:a05:651c:204b:: with SMTP id t11mr35902695ljo.94.1641218022559;
        Mon, 03 Jan 2022 05:53:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c4sm3635249lfm.160.2022.01.03.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:53:42 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1488110443C; Mon,  3 Jan 2022 16:54:00 +0300 (+03)
Date:   Mon, 3 Jan 2022 16:54:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
>  - As to testing & runtime behavior: while all of these patches are 
>    intended to be bug-free, I did find a couple of semi-bugs in the kernel 
>    where a specific order of headers guaranteed a particular code 
>    generation outcome - and if that header order was disturbed, the kernel 
>    would silently break and fail to boot ...

Looks like you are doing a lot of uninlining. Do you see any runtime
performance degradation with the patchset?

-- 
 Kirill A. Shutemov
