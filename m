Return-Path: <linux-arch+bounces-12908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9DB10C45
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB1B7B876C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F22E0B44;
	Thu, 24 Jul 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp7O1/Q3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99F2DECCA
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365387; cv=none; b=NHeJilDPMtnGi+iaO8LKjoxUvDTez2Gibo+giMHlkhLwMYDe+KZ7OVmE3/JXz1Jl7okJEBj3fzVK0vLl0NLJEqfhl5EA1Tu6ccbvNpjZTTf3gGre6MUrIiU6cnGSyYa1K9DDivdv2UZ8pE24usamqppYywa19fqeg0VgG4/tbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365387; c=relaxed/simple;
	bh=PINfP31Uv54+8D72YX70+7lUeVH3jRfFjtvMSeM9ulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+qEOzDNYTBtA9gQVCle09SQQUz3z+ZaejuvGFT00Agk4XhRzcx8W4tJjrZom83ZEI9FxPbwab7cZJk7yjeeR+jjMadDjJnqOYbM8ayKHaE6WcBwMs0KReL8QeRhz0LznBFcFM6vCpYoy2atHlYQ0jB8Ss/CeLZRGAEGW6E5ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bp7O1/Q3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-454f428038eso9176155e9.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365383; x=1753970183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5bTh+3Vvg3yCOBzS0gI9x4Skq8JpHTqDTkP6m6Co9I=;
        b=Bp7O1/Q3xvPEVICeaOTeyvLwuJmcqeC6zqp6qljZd4e8DpedmERDcwLOVnUVDnHqE2
         vwsEWtJGw9MtgtqxByfudKP1LWy+zCilrblNqpWH0i4+J5r36qMVtI/vcPrI3OarHxaF
         aCZZabPT6gCXK7tdLIkqSttj30JiVCZ8lIxpO+5yd/PLXSYC0HfLNu0vSIVSq0bOm0La
         Li/7IyOC0ncduiJZ87UI5oh7+LJWRSbqzUmaADu8dJDSUGC2/VKq4gaHzE9R/LPm3p5E
         722gEpNB4LzPNtfrzZ6W4+dthepbkpmdeMMUr02SzvjhIvjbZjX5U2wQKt0KfYJ3tnFz
         Grgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365383; x=1753970183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5bTh+3Vvg3yCOBzS0gI9x4Skq8JpHTqDTkP6m6Co9I=;
        b=N3xT9tWr5IcQ3hK1DM04mSgs1ZtAkbfhA0nMv9iJjGihK6WY6iuh1CK2hI72shrye3
         FIFCpNp1wD3RYaEZeFVwk8gjrXUg464wFkY/C9Kd8vMjJWlyRWvHdmkF53gT7JVRACtT
         8rWPLZxvtq51hO+GLGk6thkmMkTkNaR01CzLeoq910L+FnJMDQPIzBhffHCZ58FNy7UP
         yBej2eMI8dHFR09f0mxYBmXO6JDpga3jnshfijxEIo8QyLML2zEdcLWdSJbsx2Wwj/MJ
         dpm8bMzbYZe6GbOVrpcfgi3yJWkaOt+9k/jaPSDBBQx893MorJHWDLIVgqF5r2dPCBLI
         FHgw==
X-Forwarded-Encrypted: i=1; AJvYcCVqQI9IAnOqoPRHDHcwmDIT95Nu1VvCX9Fedapd8HgA/610myqrs9t+EQsHbRhP0ZWBpBNHoDz7SPul@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0LiPF/GKjLHi16DdPN7eS9QiuVCohv3lxirXdohZQgO1gRME
	tBcygB/IburrBgwws/0/7CgFWHjm5qMahmhlh7Rp+1Ycl+e7RgZeaxOWQbEePpLiIEgkQu7Bu8k
	uiPhSIZ8=
X-Gm-Gg: ASbGncuRZ+tNwzuF74LMXS0Dm1NqbAr+uOROEcnaZYRt6Zmxbekc1mF+ScdUeevurhZ
	SvhUwI5tSuezM8vfUD5AOrTcWGDt/15oyH4AYm+z4bDA5X2HAJDTsXGCRMQH3RULSAd8k81dt18
	FAeaJ8pWOhmY8aqr0FYz/pgBqR2BNxjQP5ItsoqZEyIZk+xQYW/+r6ppJBX1GKNqSQWcYW7lnkm
	rUSGS5j713BdzGwwCTNTQ9agBCQfjFz1EQ32RGHze2noFVrhKsrxx8Sjh0oWjEXAYB5w6BKLBb0
	Bi0Ml98ZXGTnh4SlKS1L5STKbtdVhakquMUSA+8VXK9sfFFTL9mt+27wNH4VeqNdlJ9A25liO/4
	OTkiZuNqWixxCQ8/T4jTTdHb8YLve5D4UuLvO2zLSm6i+YHiE5PUd0xV7rzYqscP9oGhzoSqDf7
	xbnkC9yPBZYGfn
X-Google-Smtp-Source: AGHT+IEIzq0FBEBm3LdZcFOEY9/KwPes9i1IaDCT4onRneKKA+Xc4u6PgwWHdq2thr0dEpYstk90ZQ==
X-Received: by 2002:a05:600c:4586:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-4586a8ce621mr55841895e9.7.1753365383404;
        Thu, 24 Jul 2025 06:56:23 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:23 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 02/29] Documentation: add kmemdump
Date: Thu, 24 Jul 2025 16:54:45 +0300
Message-ID: <20250724135512.518487-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new kmemdump kernel feature.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/debug/index.rst    | 17 ++++++
 Documentation/debug/kmemdump.rst | 98 ++++++++++++++++++++++++++++++++
 MAINTAINERS                      |  1 +
 3 files changed, 116 insertions(+)
 create mode 100644 Documentation/debug/index.rst
 create mode 100644 Documentation/debug/kmemdump.rst

diff --git a/Documentation/debug/index.rst b/Documentation/debug/index.rst
new file mode 100644
index 000000000000..9a9365c62f02
--- /dev/null
+++ b/Documentation/debug/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+kmemdump
+===
+
+.. toctree::
+   :maxdepth: 1
+
+   kmemdump
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
new file mode 100644
index 000000000000..3301abcaed7e
--- /dev/null
+++ b/Documentation/debug/kmemdump.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+kmemdump
+==========================
+
+This document provides information about the kmemdump feature.
+
+Overview
+========
+
+kmemdump is a mechanism that allows any driver or producer to register a
+chunk of memory into kmemdump, to be used at a later time for a specific
+purpose like debugging or memory dumping.
+
+kmemdump allows a backend to be connected, this backend interfaces a
+specific hardware that can debug or dump the memory registered into
+kmemdump.
+
+kmemdump Internals
+=============
+
+API
+----
+
+A memory region is being registered with a call to `kmemdump_register` which
+takes as parameters the ID of the region, a pointer to the virtual memory
+start address and the size. If successful, this call returns an unique ID for
+the allocated zone (either the requested ID or an allocated ID).
+IDs are predefined in the kmemdump header. A second registration with the
+same ID is not allowed, the caller needs to deregister first.
+A dedicated NO_ID is defined, which has kmemdump allocate a new unique ID
+for the request and return it. This case is useful with multiple dynamic
+loop allocations where ID is not significant.
+
+The region would be registered with a call to `kmemdump_unregister` which
+takes the id as a parameter.
+
+For dynamically allocated memory, kmemdump defines a variety of wrappers
+on top of allocation functions which are given as parameters.
+This makes the dynamic allocation easy to use without additional calls
+to registration functions. However kmemdump still exposes the register API
+for cases where it may be needed (e.g. size is not exactly known at allocation
+time).
+
+For static variables, a variety of annotation macros are provided. These
+macros will create an annotation struct inside a separate section.
+
+
+Backend
+-------
+
+Backend is represented by a `struct kmemdump_backend` which has to be filled
+in by the backend driver. Further, this struct is being passed to kmemdump
+with a `backend_register` call. `backend_unregister` will remove the backend
+from kmemdump.
+
+Once a backend is being registered, all previously registered regions are
+being sent to the backend for registration.
+
+When the backend is being removed, all regions are being first deregistered
+from the backend.
+
+kmemdump will request the backend to register a region with `register_region`
+call, and deregister a region with `unregister_region` call. These two
+functions are mandatory to be provided by a backend at registration time.
+
+Data structures
+---------------
+
+`struct kmemdump_backend` represents the kmemdump backend and it has two
+function pointers, one called `register_region` and the other
+`unregister_region`.
+There is a default backend that does a no-op that is initially registered
+and is registered back if the current working backend is being removed.
+
+The regions are being stored in a simple fixed size array. It avoids
+memory allocation overhead. This is not performance critical nor does
+allocating a few hundred entries create a memory consumption problem.
+
+The static variables registered into kmemdump are being annotated into
+a dedicated `.kemdump` memory section. This is then walked by kmemdump
+at a later time and each variable is registered.
+
+kmemdump Initialization
+------------------
+
+After system boots, kmemdump will be ready to accept region registration
+from producer drivers. Even if the backend may not be registered yet,
+there is a default no-op backend that is registered. At any time the backend
+can be changed with a real backend in which case all regions are being
+registered to the new backend.
+
+backend functionality
+-----------------
+
+kmemdump backend can keep it's own list of regions and use the specific
+hardware available to dump the memory regions or use them for debugging.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e8da575025c..ef0ffdfaf3de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13620,6 +13620,7 @@ F:	drivers/iio/accel/kionix-kx022a*
 KMEMDUMP
 M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
+F:	Documentation/debug/kmemdump.rst
 F:	drivers/debug/kmemdump.c
 F:	include/linux/kmemdump.h
 
-- 
2.43.0


