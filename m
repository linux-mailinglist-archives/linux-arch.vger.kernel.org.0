Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7036421E4C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhJEFoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhJEFnp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8BC0617A8;
        Mon,  4 Oct 2021 22:41:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m21so18690266pgu.13;
        Mon, 04 Oct 2021 22:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFgxHPU246K2Qd2iZ9FPnjvlT4kP2xuwZmDeybJhhzg=;
        b=NSZ5I8A0BDdzAzDpUX1aU3QZzQzhYEhxfjF69z01CLcPbGIlV6w47158NvBMzslF86
         E2e/cyfq243sMaVeUP5P/ZCxh92gmf7lavftuqzBwHTOJbKi1DMx0bTDQu/knznTEBEk
         IjMoK4bpse7Gq6KZmmeO6wpq7qI44cplNXbF7pvxr5nor4ARArgKLyeTJ3cRYapnjmFb
         VZBQBI5DxftwDedXJZ5K5kHTTVHIuOLyXU5E5xR3nBVVPDKNsVSqV+7aXb67FtKOOe77
         QcICA4lKw0iNRL9ofzv/RFd+6nOJOlRr8VLdoxArIrSq2hsiMPxB4wCKrTPkCkve80rL
         Jhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFgxHPU246K2Qd2iZ9FPnjvlT4kP2xuwZmDeybJhhzg=;
        b=EAqPe+YiPi+S4WmaQFLfI1/MUU6jxudycq3G4p6/vZjLm03n6Rml8KbjrB3MAUZRMJ
         LhV+Q45o8Ol+U8GMPcC0Yo/MaWkFrUqoMXMutsONOJdtZtFkSJPyW58JVGky6IKg9BhR
         xyRmtLUhyHU6YwNBzt5kIOKznA/C5GZxt+yxkvT+x1Rk7jjCjqfwQ0IjGpftn1HWa2St
         93d7cJKDnDs5Dbl3gt8RRY+CMB40AFW6BUZnrl11XcInJQRfGSX47zzZkAEWVuPtC8Yx
         +3WRlnKW5YVwUA8ODQiCCTOv+Tbh5OGTtYlm+4smcuuX182f3xT3QjbXmOK63HIVh7Ox
         tEzg==
X-Gm-Message-State: AOAM5303bj1V+vnAXiX3EIvKx+kcrFNsw3WbAIsMunga66imzlQNtCkc
        P6CG2QlpO0k8Di4qY3Ogiu4=
X-Google-Smtp-Source: ABdhPJzOXY7wXA2VdIxEH+H9d7itHg+DPcAhV7CDvqyaZET+/ibIF+kthkZUCuvQwuMy0FOHK1ylAQ==
X-Received: by 2002:aa7:96e3:0:b0:44b:e158:584c with SMTP id i3-20020aa796e3000000b0044be158584cmr28524285pfq.43.1633412495674;
        Mon, 04 Oct 2021 22:41:35 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id r8sm16019866pgp.30.2021.10.04.22.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:35 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 12/16] Replace for_each_*_bit_from() with for_each_*_bit() where appropriate
Date:   Mon,  4 Oct 2021 22:40:55 -0700
Message-Id: <20211005054059.475634-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A couple of kernel functions call for_each_*_bit_from() with start
bit equal to 0. Replace them with for_each_*_bit().

No functional changes, but might improve on readability.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/x86/kernel/apic/vector.c         | 4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++--
 drivers/hwmon/ltc2992.c               | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c132daabe615..3e6f6b448f6a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -760,9 +760,9 @@ void __init lapic_update_legacy_vectors(void)
 
 void __init lapic_assign_system_vectors(void)
 {
-	unsigned int i, vector = 0;
+	unsigned int i, vector;
 
-	for_each_set_bit_from(vector, system_vectors, NR_VECTORS)
+	for_each_set_bit(vector, system_vectors, NR_VECTORS)
 		irq_matrix_assign_system(vector_matrix, vector, false);
 
 	if (nr_legacy_irqs() > 1)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index cc5b07f86346..789acae37f55 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1047,7 +1047,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 {
-	unsigned int i = 0;
+	unsigned int i;
 
 	dev_err(gpu->dev, "recover hung GPU!\n");
 
@@ -1060,7 +1060,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 
 	/* complete all events, the GPU won't do it after the reset */
 	spin_lock(&gpu->event_spinlock);
-	for_each_set_bit_from(i, gpu->event_bitmap, ETNA_NR_EVENTS)
+	for_each_set_bit(i, gpu->event_bitmap, ETNA_NR_EVENTS)
 		complete(&gpu->event_free);
 	bitmap_zero(gpu->event_bitmap, ETNA_NR_EVENTS);
 	spin_unlock(&gpu->event_spinlock);
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 2a4bed0ab226..7352d2b3c756 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -248,8 +248,7 @@ static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 
 	gpio_status = reg;
 
-	gpio_nr = 0;
-	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
+	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
 		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
 			set_bit(gpio_nr, bits);
 	}
-- 
2.30.2

