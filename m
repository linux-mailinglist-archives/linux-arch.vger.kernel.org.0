Return-Path: <linux-arch+bounces-6912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E93968810
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197DEB25A9B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9020125B;
	Mon,  2 Sep 2024 12:56:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5A19C56C;
	Mon,  2 Sep 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281775; cv=none; b=dAdvx3lUftmi75SDaPp2mr6hIZLqfYrl8Wv7kdeWdiIibND/YsIEI0bWVyFfzr22RhftTEbtPpndOGIiL0Mlwx8t4I8VA399RNOE5NFiAoQRYkzjNHOm3tj+MN2+fGSqLkh8MgWyHj2TtYZZpVlW44WUCcVn3JIUKkvdxsfiT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281775; c=relaxed/simple;
	bh=Cvmn/MxRHMteSCvHfVIVw9TsmLnSkdvoBYquXqAFVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0BHoktOGoWfMqLQlLvju3xoDaHDKIv/xcw0xxcy/ZDJyyM9u8MNvgEBj8uDtP8UUqjXNdSnSXbIG1bJB7i2UjF6RuuNb/TONqYPQhlCQeGGtMctzgBicJA0Zcslh3WL3olfnTE9enQoKzpk0DIwmIsHaVHRcPVkMmVzZcyKnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so808991a12.1;
        Mon, 02 Sep 2024 05:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281768; x=1725886568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AulFetis4hJ4nBZpqnAuP4LAKnJB+TKmCm7LCByyUks=;
        b=QEkSYTgriPOzL+KcLXKoBire/NibH5z6gK9m6OHzNW9mLr6MlHadhzCtKny60vy5ev
         nQ+2IqX+PNA5XmCHgzvnfpbxYz0QJK9z2pS8SAqjLTFhh4g1ISi29csDxkw8/Jj0lgWE
         kwr+lPIutpflHLyUzhYe5LcvkZCvi4uaYCpg1/bvQmP/gPfmNWkZNU3e2xt5SIG2XBwQ
         n0PMSG8hFiz13zF+Y6P5332uJdH8y6bvlEQMAApc9XalzMbocdJ8q8WuH5kcmw2Uv6H5
         H2leq7Gy1/8VVJaei4GUqX0u9VdTecC7NP9fMx4PvDjOMntpN2xw6RothtuTwWSvF2lL
         /7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9W79ggLWg8nit+IQc/goUO0dpDR/FhsIiQUKZ7y4/qKFE3kLjMqwpVPpwED3O3rspr+IqyL3UZmLJIQ=@vger.kernel.org, AJvYcCUuMoQbSCx4suIS1sefSSiT6pmjd+sh5Oa29bbnRPfFKLQbBItIw7KH60hZV6kqCBpv0Vn9kdWdXPn3@vger.kernel.org, AJvYcCXEr7ZBMqFJWvYaj7CwXWcoG5ihlNipgkokIeZzfoR/P+Kv0O15AITyPf3bchDREdSVSlnBF+wx++U+jw==@vger.kernel.org, AJvYcCXP+cuKE0TF049McR+nqnbJyI24/cdUfvK1ntJwhVXWsV6xRXHRQ5yI9CI5vNt+UTjkcGPh4kDRt27f@vger.kernel.org, AJvYcCXR8AenZPU6vibNjf/iJ553Le8Hoq3xguxwBuGWikdpPtzNSIv6ZKd+GDUAyJQ8UmNeePvhT7yRzkLb@vger.kernel.org, AJvYcCXUmB2u0lB3kjQenZ2+28rQAoKC7Lf99PuynafDrsUpsGlxvA6KrSUBj2Hh2/SSQSxMa5RNMCrtN903lbZy@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPvCZ1NVk18752w0ZtWBcgRmM3Gdyn4FYg1J9IoNX5gacYFar
	6u+qDF3fgCDj6H+oaISjS0rh4yHG0sS3EBbqlpMGdfVyE9lka4Xx
X-Google-Smtp-Source: AGHT+IGCS78pvxIBdvjRBXHwluMlTuEf25Ac7vqcWSYoAo8knsAvDiU3YKvjT6NaTY3ZnyYh3nukxQ==
X-Received: by 2002:a05:6402:35d2:b0:5c2:43bd:8d3d with SMTP id 4fb4d7f45d1cf-5c243bd90eamr5092738a12.15.1725281767568;
        Mon, 02 Sep 2024 05:56:07 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c1f7sm5242435a12.42.2024.09.02.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:56:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Akira Yokosawa <akiyks@gmail.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: leit@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Moon <john@jmoon.dev>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	SeongJae Park <sj@kernel.org>,
	"Ran.Park" <ranpark@foxmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Remington Brasga <rbrasga@uci.edu>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	John Garry <john.g.garry@oracle.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Yu Kuai <yukuai3@huawei.com>,
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2] docs: Move fault injection section to dev-tools
Date: Mon,  2 Sep 2024 05:53:11 -0700
Message-ID: <20240902125421.569668-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Fault injection is a development tool, and should be under dev-tools
section.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
  * Fixed a remaining file pointing to the wrong file, as reported by
    kernel test robot:
	* https://lore.kernel.org/all/202408312350.DEf53QzI-lkp@intel.com/ 

v1:
  * https://lore.kernel.org/all/20240830174502.3732959-1-leitao@debian.org/

 Documentation/admin-guide/kernel-parameters.txt              | 2 +-
 .../{ => dev-tools}/fault-injection/fault-injection.rst      | 0
 Documentation/{ => dev-tools}/fault-injection/index.rst      | 0
 .../fault-injection/notifier-error-inject.rst                | 0
 .../{ => dev-tools}/fault-injection/nvme-fault-injection.rst | 0
 .../{ => dev-tools}/fault-injection/provoke-crashes.rst      | 0
 Documentation/dev-tools/index.rst                            | 1 +
 Documentation/index.rst                                      | 1 -
 Documentation/process/4.Coding.rst                           | 2 +-
 Documentation/process/submit-checklist.rst                   | 2 +-
 Documentation/translations/it_IT/process/4.Coding.rst        | 2 +-
 .../translations/it_IT/process/submit-checklist.rst          | 2 +-
 Documentation/translations/ja_JP/SubmitChecklist             | 2 +-
 .../translations/sp_SP/process/submit-checklist.rst          | 2 +-
 Documentation/translations/zh_CN/index.rst                   | 2 +-
 Documentation/translations/zh_CN/process/4.Coding.rst        | 2 +-
 .../translations/zh_CN/process/submit-checklist.rst          | 2 +-
 Documentation/translations/zh_TW/index.rst                   | 2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst        | 2 +-
 .../translations/zh_TW/process/submit-checklist.rst          | 2 +-
 MAINTAINERS                                                  | 2 +-
 drivers/block/null_blk/main.c                                | 2 +-
 drivers/misc/lkdtm/core.c                                    | 2 +-
 drivers/ufs/core/ufs-fault-injection.c                       | 2 +-
 include/asm-generic/error-injection.h                        | 5 +++--
 include/linux/fault-inject.h                                 | 2 +-
 lib/Kconfig.debug                                            | 4 ++--
 tools/testing/fault-injection/failcmd.sh                     | 2 +-
 28 files changed, 25 insertions(+), 24 deletions(-)
 rename Documentation/{ => dev-tools}/fault-injection/fault-injection.rst (100%)
 rename Documentation/{ => dev-tools}/fault-injection/index.rst (100%)
 rename Documentation/{ => dev-tools}/fault-injection/notifier-error-inject.rst (100%)
 rename Documentation/{ => dev-tools}/fault-injection/nvme-fault-injection.rst (100%)
 rename Documentation/{ => dev-tools}/fault-injection/provoke-crashes.rst (100%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..70d2077c9b3f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1532,7 +1532,7 @@
 	fail_make_request=[KNL]
 			General fault injection mechanism.
 			Format: <interval>,<probability>,<space>,<times>
-			See also Documentation/fault-injection/.
+			See also Documentation/dev-tools/fault-injection/.
 
 	fb_tunnels=	[NET]
 			Format: { initns | none }
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/dev-tools/fault-injection/fault-injection.rst
similarity index 100%
rename from Documentation/fault-injection/fault-injection.rst
rename to Documentation/dev-tools/fault-injection/fault-injection.rst
diff --git a/Documentation/fault-injection/index.rst b/Documentation/dev-tools/fault-injection/index.rst
similarity index 100%
rename from Documentation/fault-injection/index.rst
rename to Documentation/dev-tools/fault-injection/index.rst
diff --git a/Documentation/fault-injection/notifier-error-inject.rst b/Documentation/dev-tools/fault-injection/notifier-error-inject.rst
similarity index 100%
rename from Documentation/fault-injection/notifier-error-inject.rst
rename to Documentation/dev-tools/fault-injection/notifier-error-inject.rst
diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/dev-tools/fault-injection/nvme-fault-injection.rst
similarity index 100%
rename from Documentation/fault-injection/nvme-fault-injection.rst
rename to Documentation/dev-tools/fault-injection/nvme-fault-injection.rst
diff --git a/Documentation/fault-injection/provoke-crashes.rst b/Documentation/dev-tools/fault-injection/provoke-crashes.rst
similarity index 100%
rename from Documentation/fault-injection/provoke-crashes.rst
rename to Documentation/dev-tools/fault-injection/provoke-crashes.rst
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 53d4d124f9c5..ade850c4b344 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
    ktap
    checkuapi
    gpio-sloppy-logic-analyzer
+   Fault injection <fault-injection/index>
 
 
 .. only::  subproject and html
diff --git a/Documentation/index.rst b/Documentation/index.rst
index f9f525f4c0dd..9b57d6bc04f4 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -57,7 +57,6 @@ Various other manuals with useful information for all kernel developers.
    Testing guide <dev-tools/testing-overview>
    Hacking guide <kernel-hacking/index>
    Tracing <trace/index>
-   Fault injection <fault-injection/index>
    Livepatching <livepatch/index>
    Rust <rust/index>
 
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 80bcc1cabc23..1fc0a7fc2f43 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -300,7 +300,7 @@ enabled, a configurable percentage of memory allocations will be made to
 fail; these failures can be restricted to a specific range of code.
 Running with fault injection enabled allows the programmer to see how the
 code responds when things go badly.  See
-Documentation/fault-injection/fault-injection.rst for more information on
+Documentation/dev-tools/fault-injection/fault-injection.rst for more information on
 how to use this facility.
 
 Other kinds of errors can be found with the "sparse" static analysis tool.
diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index e531dd504b6c..b513b3d05426 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -124,7 +124,7 @@ Test your code
 3) All codepaths have been exercised with all lockdep features enabled.
 
 4) Has been checked with injection of at least slab and page-allocation
-   failures.  See ``Documentation/fault-injection/``.
+   failures.  See ``Documentation/dev-tools/fault-injection/``.
    If the new code is substantial, addition of subsystem-specific fault
    injection might be appropriate.
 
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index ec874a8dfb9d..b7b9ab6df103 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -317,7 +317,7 @@ di allocazione di memoria sarà destinata al fallimento; questi fallimenti
 possono essere ridotti ad uno specifico pezzo di codice.  Procedere con
 l'inserimento dei fallimenti attivo permette al programmatore di verificare
 come il codice risponde quando le cose vanno male.  Consultate:
-Documentation/fault-injection/fault-injection.rst per avere maggiori
+Documentation/dev-tools/fault-injection/fault-injection.rst per avere maggiori
 informazioni su come utilizzare questo strumento.
 
 Altre tipologie di errori possono essere riscontrati con lo strumento di
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 2fc09cc1f0be..60ec660702fa 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -99,7 +99,7 @@ sottomissione delle patch, in particolare
     essere inviate in copia anche a linux-api@vger.kernel.org.
 
 20) La patch è stata verificata con l'iniezione di fallimenti in slab e
-    nell'allocazione di pagine.  Vedere ``Documentation/fault-injection/``.
+    nell'allocazione di pagine.  Vedere ``Documentation/dev-tools/fault-injection/``.
 
     Se il nuovo codice è corposo, potrebbe essere opportuno aggiungere
     l'iniezione di fallimenti specifici per il sottosistema.
diff --git a/Documentation/translations/ja_JP/SubmitChecklist b/Documentation/translations/ja_JP/SubmitChecklist
index 1759c6b452d6..193641581e98 100644
--- a/Documentation/translations/ja_JP/SubmitChecklist
+++ b/Documentation/translations/ja_JP/SubmitChecklist
@@ -90,7 +90,7 @@ Linux カーネルパッチ投稿者向けチェックリスト
 
 19: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
     挙動について、fault-injectionを利用して確認してください。
-    Documentation/fault-injection/ を参照してください。
+    Documentation/dev-tools/fault-injection/ を参照してください。
 
     追加したコードがかなりの量であったならば、サブシステム特有の
     fault-injectionを追加したほうが良いかもしれません。
diff --git a/Documentation/translations/sp_SP/process/submit-checklist.rst b/Documentation/translations/sp_SP/process/submit-checklist.rst
index 0d6651f9d871..d2b09a10c1fe 100644
--- a/Documentation/translations/sp_SP/process/submit-checklist.rst
+++ b/Documentation/translations/sp_SP/process/submit-checklist.rst
@@ -102,7 +102,7 @@ y en otros lugares con respecto al envío de parches del kernel de Linux.
     espacio de usuario deben ser CCed a linux-api@vger.kernel.org.
 
 19) Se ha comprobado con la inyección de al menos errores de asignación
-    de slab y página. Consulte ``Documentation/fault-injection/``.
+    de slab y página. Consulte ``Documentation/dev-tools/fault-injection/``.
 
     Si el nuevo código es sustancial, la adición de la inyección de
     errores específica del subsistema podría ser apropiada.
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 20b9d4270d1f..e471f22a5473 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -73,7 +73,7 @@
 TODOList:
 
 * trace/index
-* fault-injection/index
+* dev-tools/fault-injection/index
 * livepatch/index
 
 面向用户的文档
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index 4cc35d410dbc..2794761a1cbe 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -208,7 +208,7 @@ Linus对这个问题给出了最佳答案:
 启用故障注入后，内存分配的可配置失败的百分比；这些失败可以限定在特定的代码
 范围内。在启用了故障注入的情况下运行，程序员可以看到当情况恶化时代码如何响
 应。有关如何使用此工具的详细信息，请参阅
-Documentation/fault-injection/fault-injection.rst。
+Documentation/dev-tools/fault-injection/fault-injection.rst。
 
 “sparse”静态分析工具可以发现其他类型的错误。sparse可以警告程序员用户空间
 和内核空间地址之间的混淆、大端序与小端序的混淆、在需要一组位标志的地方传递
diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
index 10536b74aeec..4f8d7480673d 100644
--- a/Documentation/translations/zh_CN/process/submit-checklist.rst
+++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
@@ -85,7 +85,7 @@ Linux内核补丁提交检查单
     请参阅 ``Documentation/ABI/README`` 。更改用户空间接口的补丁应该抄送
     linux-api@vger.kernel.org。
 
-19) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/fault-injection/`` 。
+19) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/dev-tools/fault-injection/`` 。
     如果新代码是实质性的，那么添加子系统特定的故障注入可能是合适的。
 
 20) 新添加的代码已经用 ``gcc -W`` 编译（使用 ``make EXTRA-CFLAGS=-W`` ）。这
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 660a74d2023c..1932a5f28069 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -64,7 +64,7 @@ TODOList:
 * kernel-hacking/index
 * rust/index
 * trace/index
-* fault-injection/index
+* dev-tools/fault-injection/index
 * livepatch/index
 
 面向用戶的文檔
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index e90a6b51fb98..3841da1e6729 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -211,7 +211,7 @@ Linus對這個問題給出了最佳答案:
 啓用故障注入後，內存分配的可配置失敗的百分比；這些失敗可以限定在特定的代碼
 範圍內。在啓用了故障注入的情況下運行，程序員可以看到當情況惡化時代碼如何響
 應。有關如何使用此工具的詳細信息，請參閱
-Documentation/fault-injection/fault-injection.rst。
+Documentation/dev-tools/fault-injection/fault-injection.rst。
 
 “sparse”靜態分析工具可以發現其他類型的錯誤。sparse可以警告程序員用戶空間
 和內核空間地址之間的混淆、大端序與小端序的混淆、在需要一組位標誌的地方傳遞
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 0ecb187753e4..e7a6c3332017 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -88,7 +88,7 @@ Linux內核補丁提交檢查單
     請參閱 ``Documentation/ABI/README`` 。更改用戶空間接口的補丁應該抄送
     linux-api@vger.kernel.org。
 
-19) 已通過至少注入slab和page分配失敗進行檢查。請參閱 ``Documentation/fault-injection/`` 。
+19) 已通過至少注入slab和page分配失敗進行檢查。請參閱 ``Documentation/dev-tools/fault-injection/`` 。
     如果新代碼是實質性的，那麼添加子系統特定的故障注入可能是合適的。
 
 20) 新添加的代碼已經用 ``gcc -W`` 編譯（使用 ``make EXTRA-CFLAGS=-W`` ）。這
diff --git a/MAINTAINERS b/MAINTAINERS
index e4fa9010fcb6..b5fd319b8786 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8537,7 +8537,7 @@ F:	drivers/net/wan/farsync.*
 FAULT INJECTION SUPPORT
 M:	Akinobu Mita <akinobu.mita@gmail.com>
 S:	Supported
-F:	Documentation/fault-injection/
+F:	Documentation/dev-tools/fault-injection/
 F:	lib/fault-inject.c
 
 FBTFT Framebuffer drivers
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..2266c80649a2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -100,7 +100,7 @@ MODULE_PARM_DESC(home_node, "Home node for the device");
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 /*
  * For more details about fault injection, please refer to
- * Documentation/fault-injection/fault-injection.rst.
+ * Documentation/dev-tools/fault-injection/fault-injection.rst.
  */
 static char g_timeout_str[80];
 module_param_string(timeout, g_timeout_str, sizeof(g_timeout_str), 0444);
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..029592f2d07e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -15,7 +15,7 @@
  *
  * Debugfs support added by Simon Kagstrom <simon.kagstrom@netinsight.net>
  *
- * See Documentation/fault-injection/provoke-crashes.rst for instructions
+ * See Documentation/dev-tools/fault-injection/provoke-crashes.rst for instructions
  */
 #include "lkdtm.h"
 #include <linux/fs.h>
diff --git a/drivers/ufs/core/ufs-fault-injection.c b/drivers/ufs/core/ufs-fault-injection.c
index 169540417079..3afe1e7fb407 100644
--- a/drivers/ufs/core/ufs-fault-injection.c
+++ b/drivers/ufs/core/ufs-fault-injection.c
@@ -19,7 +19,7 @@ enum { FAULT_INJ_STR_SIZE = 80 };
 
 /*
  * For more details about fault injection, please refer to
- * Documentation/fault-injection/fault-injection.rst.
+ * Documentation/dev-tools/fault-injection/fault-injection.rst.
  */
 static char g_trigger_eh_str[FAULT_INJ_STR_SIZE];
 module_param_cb(trigger_eh, &ufs_fault_ops, g_trigger_eh_str, 0644);
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa..26b80eec6d5f 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -21,8 +21,9 @@ struct pt_regs;
 /*
  * Whitelist generating macro. Specify functions which can be error-injectable
  * using this macro. If you unsure what is required for the error-injectable
- * functions, please read Documentation/fault-injection/fault-injection.rst
- * 'Error Injectable Functions' section.
+ * functions, please read
+ * Documentation/dev-tools/fault-injection/fault-injection.rst 'Error
+ * Injectable Functions' section.
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 354413950d34..9b10e50155a6 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -12,7 +12,7 @@
 
 /*
  * For explanation of the elements of this struct, see
- * Documentation/fault-injection/fault-injection.rst
+ * Documentation/dev-tools/fault-injection/fault-injection.rst
  */
 struct fault_attr {
 	unsigned long probability;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..a0e66c01042e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2019,7 +2019,7 @@ config FAULT_INJECTION
 	depends on DEBUG_KERNEL
 	help
 	  Provide fault-injection framework.
-	  For more details, see Documentation/fault-injection/.
+	  For more details, see Documentation/dev-tools/fault-injection/.
 
 config FAILSLAB
 	bool "Fault-injection capability for kmalloc"
@@ -2225,7 +2225,7 @@ config LKDTM
 	called lkdtm.
 
 	Documentation on how to use the module can be found in
-	Documentation/fault-injection/provoke-crashes.rst
+	Documentation/dev-tools/fault-injection/provoke-crashes.rst
 
 config CPUMASK_KUNIT_TEST
 	tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
index 78dac34264be..ea384c7cae68 100644
--- a/tools/testing/fault-injection/failcmd.sh
+++ b/tools/testing/fault-injection/failcmd.sh
@@ -42,7 +42,7 @@ OPTIONS
 	--interval=value, --space=value, --verbose=value, --task-filter=value,
 	--stacktrace-depth=value, --require-start=value, --require-end=value,
 	--reject-start=value, --reject-end=value, --ignore-gfp-wait=value
-		See Documentation/fault-injection/fault-injection.rst for more
+		See Documentation/dev-tools/fault-injection/fault-injection.rst for more
 		information
 
 	failslab options:
-- 
2.43.5


