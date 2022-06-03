Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE853C2C5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiFCBp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbiFCBp0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 21:45:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513CF24086;
        Thu,  2 Jun 2022 18:45:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h1so5835077plf.11;
        Thu, 02 Jun 2022 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ykexnotmnCEPoI5Oth3kNZn8Re9RXxRddiJBLrLWIBA=;
        b=glhKnCIao23XEkXQATLZXMVvZO+5umzisEWt5K4eEWqTXZb+jZpia8bGHlKmiu44DU
         M0CRLXBiX+RmhTNjZ/tJfyGUya0aP6tYXif87iKHnto+wiquodWSVDLr76/3cbw9BVpZ
         YQbJjhulDJuBkphx80ANkgad209aaT2VvpzL8JuSIycIgh1jop3w7ivErMmMOG8VI7Le
         ygrddEQfGY5HbpVifa1RhFnF2qiwPlvfOGDKy1FiOrNdiXA5m6BLiDVOhVMoqkbUBLQW
         KzgK0Ke3fF2MkGyDyKWraHCg8bfBtUfBqABJSH/gOTaAzJ8ZBd8aYjGVMHQKXRs0rPg1
         20Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykexnotmnCEPoI5Oth3kNZn8Re9RXxRddiJBLrLWIBA=;
        b=QaokvplYBA+PTN905t92YPj9T6yEjWreOn91cGEYJWfy04M7h55xdUICm7JaBXzceT
         RHjCBbfIIOgDmuvMQqicHWhllGnlMyVNNzVEqu6u9PK75gVGDataF2HhBV0w+zErZlSz
         K7SZ3XJfe/Q6UMSa6D3sIU7+q/96Dfdyv2baw6GUoPHeG3RMy9RS77EnhTpEiQs/o7dn
         QY8yo+5iUz0N+nZ9loTJt47XffZfOjvpsFZw7aknCCC1HNTSl4j4qD5SBC1hVt5ju4dQ
         3sHXkybAAOhJ3BI6GsFji+4e1c8GI7/OOsTzU/mnerDZjSCRIHkMoe4NVSyFlrA9lHIr
         yW0w==
X-Gm-Message-State: AOAM533NRVPchBR985XsokTjU0QBXTq1K/dOSrOW6p+o/dpfJ2djT+g0
        W9KmAmYsAqQ379UC38/LUME=
X-Google-Smtp-Source: ABdhPJwQKvCtpbEUxQ5HEb2Ha2zJG7oPPAptQTp2CQVAwj13XBwCP7OPpRBf9oVy1CTq/pm8DmSuzg==
X-Received: by 2002:a17:903:230e:b0:166:3781:1e50 with SMTP id d14-20020a170903230e00b0016637811e50mr7863272plh.20.1654220722734;
        Thu, 02 Jun 2022 18:45:22 -0700 (PDT)
Received: from localhost (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id r12-20020a17090b050c00b001e0c1044ceasm3937393pjz.43.2022.06.02.18.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:45:21 -0700 (PDT)
Date:   Fri, 3 Jun 2022 08:45:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH V14 03/24] Documentation: LoongArch: Add basic
 documentations
Message-ID: <YplnruNz++gABlU0@debian.me>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220602115141.3962749-4-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 02, 2022 at 07:51:20PM +0800, Huacai Chen wrote:
> +Legacy IRQ model
> +================
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
> +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, and then go
> +to LIOINTC, and then CPUINTC.
> +
> + +---------------------------------------------+
> + |::                                           |
> + |                                             |
> + |    +-----+     +---------+     +-------+    |
> + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> + |    +-----+     +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |                +---------+     +-------+    |
> + |                | LIOINTC | <-- | UARTs |    |
> + |                +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |               +-----------+                 |
> + |               | HTVECINTC |                 |
> + |               +-----------+                 |
> + |                ^         ^                  |
> + |                |         |                  |
> + |          +---------+ +---------+            |
> + |          | PCH-PIC | | PCH-MSI |            |
> + |          +---------+ +---------+            |
> + |            ^     ^           ^              |
> + |            |     |           |              |
> + |    +---------+ +---------+ +---------+      |
> + |    | PCH-LPC | | Devices | | Devices |      |
> + |    +---------+ +---------+ +---------+      |
> + |         ^                                   |
> + |         |                                   |
> + |    +---------+                              |
> + |    | Devices |                              |
> + |    +---------+                              |
> + |                                             |
> + |                                             |
> + +---------------------------------------------+
> +
> +Extended IRQ model
> +==================
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
> +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and then go to
> +to CPUINTC directly.
> +
> + +--------------------------------------------------------+
> + |::                                                      |
> + |                                                        |
> + |         +-----+     +---------+     +-------+          |
> + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> + |         +-----+     +---------+     +-------+          |
> + |                      ^       ^                         |
> + |                      |       |                         |
> + |               +---------+ +---------+     +-------+    |
> + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> + |               +---------+ +---------+     +-------+    |
> + |                ^       ^                               |
> + |                |       |                               |
> + |         +---------+ +---------+                        |
> + |         | PCH-PIC | | PCH-MSI |                        |
> + |         +---------+ +---------+                        |
> + |           ^     ^           ^                          |
> + |           |     |           |                          |
> + |   +---------+ +---------+ +---------+                  |
> + |   | PCH-LPC | | Devices | | Devices |                  |
> + |   +---------+ +---------+ +---------+                  |
> + |        ^                                               |
> + |        |                                               |
> + |   +---------+                                          |
> + |   | Devices |                                          |
> + |   +---------+                                          |
> + |                                                        |
> + |                                                        |
> + +--------------------------------------------------------+
> +

I think for consistency with other diagrams in Documentation/, just use
literal code block, like:

diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation/loongarch/irq-chip-model.rst
index 35c962991283ff..3cfd528021de05 100644
--- a/Documentation/loongarch/irq-chip-model.rst
+++ b/Documentation/loongarch/irq-chip-model.rst
@@ -24,40 +24,38 @@ to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
 interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, and then go
 to LIOINTC, and then CPUINTC.
 
- +---------------------------------------------+
- |::                                           |
- |                                             |
- |    +-----+     +---------+     +-------+    |
- |    | IPI | --> | CPUINTC | <-- | Timer |    |
- |    +-----+     +---------+     +-------+    |
- |                     ^                       |
- |                     |                       |
- |                +---------+     +-------+    |
- |                | LIOINTC | <-- | UARTs |    |
- |                +---------+     +-------+    |
- |                     ^                       |
- |                     |                       |
- |               +-----------+                 |
- |               | HTVECINTC |                 |
- |               +-----------+                 |
- |                ^         ^                  |
- |                |         |                  |
- |          +---------+ +---------+            |
- |          | PCH-PIC | | PCH-MSI |            |
- |          +---------+ +---------+            |
- |            ^     ^           ^              |
- |            |     |           |              |
- |    +---------+ +---------+ +---------+      |
- |    | PCH-LPC | | Devices | | Devices |      |
- |    +---------+ +---------+ +---------+      |
- |         ^                                   |
- |         |                                   |
- |    +---------+                              |
- |    | Devices |                              |
- |    +---------+                              |
- |                                             |
- |                                             |
- +---------------------------------------------+
+ ::                                           
+                                              
+     +-----+     +---------+     +-------+    
+     | IPI | --> | CPUINTC | <-- | Timer |    
+     +-----+     +---------+     +-------+    
+                      ^                       
+                      |                       
+                 +---------+     +-------+    
+                 | LIOINTC | <-- | UARTs |    
+                 +---------+     +-------+    
+                      ^                       
+                      |                       
+                +-----------+                 
+                | HTVECINTC |                 
+                +-----------+                 
+                 ^         ^                  
+                 |         |                  
+           +---------+ +---------+            
+           | PCH-PIC | | PCH-MSI |            
+           +---------+ +---------+            
+             ^     ^           ^              
+             |     |           |              
+     +---------+ +---------+ +---------+      
+     | PCH-LPC | | Devices | | Devices |      
+     +---------+ +---------+ +---------+      
+          ^                                   
+          |                                   
+     +---------+                              
+     | Devices |                              
+     +---------+                              
+                                              
+                                              
 
 Extended IRQ model
 ==================
@@ -67,35 +65,33 @@ to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
 interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and then go to
 to CPUINTC directly.
 
- +--------------------------------------------------------+
- |::                                                      |
- |                                                        |
- |         +-----+     +---------+     +-------+          |
- |         | IPI | --> | CPUINTC | <-- | Timer |          |
- |         +-----+     +---------+     +-------+          |
- |                      ^       ^                         |
- |                      |       |                         |
- |               +---------+ +---------+     +-------+    |
- |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
- |               +---------+ +---------+     +-------+    |
- |                ^       ^                               |
- |                |       |                               |
- |         +---------+ +---------+                        |
- |         | PCH-PIC | | PCH-MSI |                        |
- |         +---------+ +---------+                        |
- |           ^     ^           ^                          |
- |           |     |           |                          |
- |   +---------+ +---------+ +---------+                  |
- |   | PCH-LPC | | Devices | | Devices |                  |
- |   +---------+ +---------+ +---------+                  |
- |        ^                                               |
- |        |                                               |
- |   +---------+                                          |
- |   | Devices |                                          |
- |   +---------+                                          |
- |                                                        |
- |                                                        |
- +--------------------------------------------------------+
+ ::                                                      
+                                                         
+          +-----+     +---------+     +-------+          
+          | IPI | --> | CPUINTC | <-- | Timer |          
+          +-----+     +---------+     +-------+          
+                       ^       ^                         
+                       |       |                         
+                +---------+ +---------+     +-------+    
+                | EIOINTC | | LIOINTC | <-- | UARTs |    
+                +---------+ +---------+     +-------+    
+                 ^       ^                               
+                 |       |                               
+          +---------+ +---------+                        
+          | PCH-PIC | | PCH-MSI |                        
+          +---------+ +---------+                        
+            ^     ^           ^                          
+            |     |           |                          
+    +---------+ +---------+ +---------+                  
+    | PCH-LPC | | Devices | | Devices |                  
+    +---------+ +---------+ +---------+                  
+         ^                                               
+         |                                               
+    +---------+                                          
+    | Devices |                                          
+    +---------+                                          
+                                                         
+                                                         
 
 ACPI-related definitions
 ========================

Otherwise, htmldocs builds successfully without any new warnings related
to this patch series.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
