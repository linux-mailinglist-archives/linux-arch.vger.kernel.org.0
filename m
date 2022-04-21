Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365B50ABB7
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392277AbiDUXA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392250AbiDUXA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 19:00:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4533BBCD
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 15:57:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s17so6919012plg.9
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gXdf8YCenSephMaGE+Pw4ZkYPY5B5Dcbo0Qnie2IYRw=;
        b=oocSnwYWXZ12d5+KsaAG7tMGLltiGjNCX3GUW4Buxv4a44rlIlD+JyfJTaN2i16wzi
         DQJpyQH/Fyr7/EP1CamW9rX0RIPSEA0cxKmSxykjImnMmzh0Q7NSJ1jl0rxS+7hdJ/mT
         5RtnbaldCtFUVGRIxiz/IAPwFcacutqBrwJ0QtumBMSVhOUk0pTXX0JPGceRStSBSWfH
         wdw3aoGM4UIdtAh8A2IK1yNkPvTOTUYwqyZN/8tv4Y4rU3ZNK3aAZs1YVBWF8walvIiI
         uZACqsAM4Dr/E4XOMVdBaHJmJe1VtsstQSKgaeDJuwttP3ETvob8f4SRgYIdYLDvkrDS
         sKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gXdf8YCenSephMaGE+Pw4ZkYPY5B5Dcbo0Qnie2IYRw=;
        b=YTfdqcgG4ekF6wne04R9L1eeRxqqsRpUBAbMYAvZYtKlrX4Cp6XgLc8tM8z23wr7d5
         T63mIA9jkX1uQ7faaIrWiDtKmdu+DgBJATrzyki6qYhJg8NWb8BYOsXbTIwg2QHoGbdK
         yQ4Yv9HIwtGwbr+2EbU7TwJTlnnWJZQKDmtm7+/4u2u798vjfv7JIMYUlgsoRilGmaMT
         T8oElMoMfrqxcLDRIW6ZraDRJEAcCQz7yrbJLavL4sI7TV9EcKtg4O/8+zHCCXdn+laC
         RzFW3S1y+R0aSlzN9diNwuK+IM9lqqi/pLjJneNAXFuQ1ryJLLlsiclowa52WrcRQLfj
         C3Nw==
X-Gm-Message-State: AOAM530OAP8vNWuh79NDocvxOyNkaJ7V/ykdh2RbEBi4RSdNIZQvdMVd
        UouaCN3TPudEC7sY5eI6fMvVtg==
X-Google-Smtp-Source: ABdhPJxJBuALK/SqNleXIYawl1It00JHlUS6Es7ewWUN0ha6JAxxRNS4Jcouy8GhGRAAR2Wa2e9SwQ==
X-Received: by 2002:a17:90b:3b46:b0:1c7:9ca8:a19e with SMTP id ot6-20020a17090b3b4600b001c79ca8a19emr12651102pjb.245.1650581853813;
        Thu, 21 Apr 2022 15:57:33 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm155664pfc.190.2022.04.21.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:57:32 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:57:32 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Apr 2022 15:57:23 PDT (-0700)
Subject:     Re: [PATCH V3] riscv: patch_text: Fixup last cpu should be master
In-Reply-To: <20220406141649.728971-1-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com,
        mhiramat@kernel.org, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-320b7f4f-08bf-4ee8-938e-4bf687760468@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 06 Apr 2022 07:16:49 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The original idea: When the
> master CPU patch_text, the others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee the remaining CPUs are waiting. This patch changes the
> last CPU as the master to solve the potential risk.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/riscv/kernel/patch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..765004b60513 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
>  	struct patch_insn *patch = data;
>  	int ret = 0;
>
> -	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		ret =
>  		    patch_text_nosync(patch->addr, &patch->insn,
>  					    GET_INSN_LENGTH(patch->insn));

Thanks, this is on fixes.
