Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F271E29A5
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgEZSHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 14:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgEZSHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 14:07:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546BBC03E96D;
        Tue, 26 May 2020 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WWC1kKHrVuEMdArPfAi+QV3k9NA3yhSI+2WZIe2uBMk=; b=SAwBuIkba3TDTbw9zVFFvtz/dV
        dNQ36jvkyDBS2zQFDXQ6/W4n9iP4mnJ4Ls9dMtnni4Kx4rPwV6nduCEx4tSUsr21b3TU7zkk2gN/7
        DeJYAR85x2SNaAOJqaha8kU653IRM+X4ixrtlAwg/xtqxkd23Fi81TVvzMTba9dj70sPSYe1hrOEY
        78yNfsQnzMYwPENxSryuGQRvRd1Dai4sy7ItWz5u3Wfx4pvBEaSm+js24q5KBZVKQpKdJnTmvor9t
        tMthAs3Dwu3rmZ+nQnm4ZcfaKqF35H0k2qAoA63i4mWQ09tTdqt3rW7iFwRX2LX9EsT1gEe+8fz3L
        qqUM3qnA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jddyt-0004p4-1v; Tue, 26 May 2020 18:07:15 +0000
Subject: Re: [PATCH] topology: Fix cpumask_of_node macro for
 CONFIG_NEED_MULTIPLE_NODES=n
To:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
References: <20200526174443.207610-1-linux@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45fda375-3691-e722-000f-188dd13d2e0b@infradead.org>
Date:   Tue, 26 May 2020 11:07:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526174443.207610-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/26/20 10:44 AM, Guenter Roeck wrote:
> The following compile error is seen in linux-next if
> NUMA=n and CONFIG_NEED_MULTIPLE_NODES=n.
> 
>   CC      drivers/hwmon/amd_energy.o
> In file included from ../arch/x86/include/asm/cpumask.h:5:0,
>                  from ../arch/x86/include/asm/msr.h:11,
>                  from ../arch/x86/include/asm/processor.h:22,
>                  from ../arch/x86/include/asm/cpu_device_id.h:16,
>                  from ../drivers/hwmon/amd_energy.c:6:
> ../drivers/hwmon/amd_energy.c: In function 'amd_energy_read':
> ../include/asm-generic/topology.h:51:36: error:
> 			void value not ignored as it ought to be
>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
> ../include/linux/cpumask.h:618:72: note:
> 			in definition of macro 'cpumask_first_and'
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                         ^~~~~
> ../drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro 'cpumask_of_node'
> 
> cpumask_of_node() is missing () around the 'node' parameter.
> 
> Fixes: b339752d054f ("cpumask: fix spurious cpumask_of_node() on non-NUMA multi-node configs")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  include/asm-generic/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
> index 238873739550..5aa8705df87e 100644
> --- a/include/asm-generic/topology.h
> +++ b/include/asm-generic/topology.h
> @@ -48,7 +48,7 @@
>    #ifdef CONFIG_NEED_MULTIPLE_NODES
>      #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
>    #else
> -    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
> +    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
>    #endif
>  #endif
>  #ifndef pcibus_to_node
> 


-- 
~Randy
