Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8355A5CFF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 09:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH3Hd5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH3Hdz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 03:33:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8374BB6;
        Tue, 30 Aug 2022 00:33:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so12975862wrr.5;
        Tue, 30 Aug 2022 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AkyiwZAyTL+qEnClAJjmshzXLVaiiWcOqi2bEVx9lPg=;
        b=aRJmmvilCx9hvnJwsqFDPwUjBgxD5a6DXdivTL+SL6hBqXqSgsQY6k4ALeR8FvREBs
         29wLOX4jEh7pKEjjJOucUsyR6KsAsGxnleJB90+lIKMn0lwehPN+a28RBx4XSP0JcCpb
         tP05S/5Bl9i9PsRfB/mpmNAHJebhPrkZO8+cqakoCF0UxM+jgP8F9hdJ7m0dJy9698Hk
         +ix5Kdnbdj6A9npKn848lfV0UW/d3if+lSSi0fLHWNgF4jDqVxiaJ2yKNijxt2ctV/jF
         s4qgeh3LyJrpPG0ORO8pKTQBjeYKw1FdHIWS+bg0J/Hp8DM6+qamo3RDZENkCPnTqP40
         OTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AkyiwZAyTL+qEnClAJjmshzXLVaiiWcOqi2bEVx9lPg=;
        b=0k4nOyb+Q3QUklnZXSxwLRKNAhJh+Uqe8fko4VfyS8LQ/lsl9IN7YhCcQbUTpVgKEo
         zulUHDMusVXjNTD7L8FOT4R2pg7zE7m3T4HA+BmRKhptf0GJ6bdKc14aGarfzXVWLSbh
         Fb+W0p+T14YTHjqZhClMgjVRKhJ8uER0iZYIrK/ddVZz5CO+sFoA8ZByoV9i/Gan5TNH
         6uuJzQA7Vi8Q4Cer6eHKsX94O55KZlL6pw7iHxetC0xN3N7AeVQIw+HvpupsyqxtyrA+
         omHFYLV798T1jv11v20k/bPIbTIES03Zyv96zuuIl34Vu/h0YGMn4VkdTHu/d8jNILhT
         y8hA==
X-Gm-Message-State: ACgBeo31dASrLiEpLfk52hDfBDfiS5Z+ZQaa+NF6leseYPQqK3lsmcTd
        mIZdHIfd3E5B6NtsoD2KCDQ=
X-Google-Smtp-Source: AA6agR7M6K5NpAKHxyoBknJxWk60gWpGtre/xWrzuWyDehqu9BTVBu8aAalG/O21/110w8lPoNr+Bg==
X-Received: by 2002:a5d:59a2:0:b0:226:e6c3:a6c2 with SMTP id p2-20020a5d59a2000000b00226e6c3a6c2mr258841wrr.236.1661844832254;
        Tue, 30 Aug 2022 00:33:52 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id l17-20020a7bc351000000b003a5ee64cc98sm10920055wmj.33.2022.08.30.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:33:51 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:33:51 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     guoren@kernel.org
Cc:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 2/3] openrisc: ptrace: Remove duplicate operation
Message-ID: <Yw29XwOoUY1Foze/@oscomms1>
References: <20220830065316.3924938-1-guoren@kernel.org>
 <20220830065316.3924938-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830065316.3924938-3-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 02:53:15AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The TIF_SYSCALL_TRACE is controlled by a common code, see
> kernel/ptrace.c and include/linux/thread.h.
> 
> clear_task_syscall_work(child, SYSCALL_TRACE);
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/kernel/ptrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
> index b971740fc2aa..cc53fa676706 100644
> --- a/arch/openrisc/kernel/ptrace.c
> +++ b/arch/openrisc/kernel/ptrace.c
> @@ -132,7 +132,6 @@ void ptrace_disable(struct task_struct *child)
>  	pr_debug("ptrace_disable(): TODO\n");
>  
>  	user_disable_single_step(child);
> -	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
>  }
>  
>  long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
> -- 
> 2.36.1
> 
