Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B820222D51
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGPU56 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGPU55 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:57:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ABC08C5CE
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:57:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x72so4255342pfc.6
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SwyEMFp+ErfmRvKBfavJObkX63ZHWDlBU0AZqSA3cM=;
        b=gp7gddSHwynljdzF5Pyi++VHHXp3523+j+ksaqQyiIBE3mx/gOdWkqz/gLXrQTZWMa
         6Qln6bbQpO6HX6NhUySTEo234kx7nIdZEA8CEvV4UaepMbKIpUuPusb29LxB39YcZ1fI
         Uy7xcxFbX6dp6pKS5vDRBdEMuDh4MclXF+8vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SwyEMFp+ErfmRvKBfavJObkX63ZHWDlBU0AZqSA3cM=;
        b=WOnq1X9jBE+JHu0dYRfWA3dunTSkfU+bRzXKEkQCYFJcGQOABKMQCHqrnU57O6B6/I
         q5EnHfogQYcxKu+Rz9450xxkB8CUXzbTILCfz8a1ozLEFTGYuAghRXXMDoNTUta9y+2U
         oUOcxCc9rWVdnnvnq2aBRNJfaTWrQrPFarVctgejt4ohf/zIZuaXlN/5b1GTms7dE/hV
         9JzOKkTjWeEBwxxX7gvhcDPI3w4muZkrvd6L2DfTz44voQUXMOlP369sqxfjHjfNR6hX
         rp4jrlPYki5e+QjWBEgRV49edX1nT6aJR1dzHE3ZQIL/huZZlSq9cHCmljgaMCP71RDT
         d3ZA==
X-Gm-Message-State: AOAM532jl3KGdMMQkBKgdRr/cwLIMC2IpznsuTPZgLmNE3N7TdqAG0pl
        rxeAZqx2MXDDsY4ydP4aXPoPEA==
X-Google-Smtp-Source: ABdhPJxcvVP5+z1lNxoACOmOIX5dg+crk6+nC/bsWsDAWi7zo0SyljXZtoO8siv16OCxbzLZZR5h8w==
X-Received: by 2002:a63:9201:: with SMTP id o1mr5156170pgd.99.1594933076523;
        Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20sm5704209pfc.158.2020.07.16.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:57:55 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:57:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for
 entry/exit
Message-ID: <202007161357.70EF223F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.658427667@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.658427667@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:15PM +0200, Thomas Gleixner wrote:
> As a preparatory step for moving the syscall and interrupt entry/exit
> handling into generic code, provide pt_regs helpers which allow to:
> 
>   - Retrieve the syscall number from pt_regs
>   - Retrieve the syscall return value from pt_regs
>   - Retrieve the interrupt state from pt_regs to check whether interrupts
>     are reenabled by return from interrupt/exception.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
