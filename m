Return-Path: <linux-arch+bounces-15767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA2FD18C64
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CF93300ACB9
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2A38F95E;
	Tue, 13 Jan 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rKo9Ainu"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149238F225;
	Tue, 13 Jan 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307867; cv=none; b=JE85qp0j3he9c4Gk37vpzdnnTgtptqU6t+ABu+9PPwHL3wU6ByhQfg2gx6IC8LR3RQGr5SHvcazwSUs4ggcT7p/vU2UOAU3szcrkGFnDC5FhkZmSorJmfrQKCYuYeXN8jpKJjTUyTLIAPEv/AE7amcNRqdHNzwvaiNmkh7Nv/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307867; c=relaxed/simple;
	bh=3mMY1GM1VQS8nWhP55kjhRmx1RnZj3EJmp3vjjgzg8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0zVOnlEvyDXwXDmmy5movXenHs4Yge/6PyZ35V9jpWIMCHd/QOVpIMvBky8hkZP4C/k/ilAqZHbTQSIKulbopqBIl1fP4muyGHcRT2bZVnSFmohpEa8KsxNhS98DmsWbJzPLKdtRmGe8BIAbDjLq9vxDUxeaK3Eq3OfC74Rydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rKo9Ainu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307859;
	bh=3mMY1GM1VQS8nWhP55kjhRmx1RnZj3EJmp3vjjgzg8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rKo9Ainu3XohS3vDOhDSBVDMKqoArsw3k6VH6Rq2OcD6WPWA0c6vsb0GoDtVSXluv
	 sgo/XicYHPxC7xBe5EgzHnfehmzjKt4EAac0PhhkT1cn/koDo8ejH70xmQx3KomGYL
	 /OfN167o6WiGNK2fmRsgBoWzSVQABRqeZL7Ntj6U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:45 +0100
Subject: [PATCH v4 01/17] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-module-hashes-v4-1-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Nicolas Schier <nsc@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Coiby Xu <coxu@redhat.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=2701;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LKgyKjITAXJ1z3S+DyfR5AT2mA+k6KdtH/VMhlJUCys=;
 b=5Saf759AOy7OgxG9vCafXOFEi9YsNl9IxQ4NXimYkvoPD101bf62Qlcvkk3kzegkDK+79KIxZ
 R78B0PNlMSPDAG06hzuwwcndV6Fs1j6RV8THFOsAFuXJ+B/Q/fJxYAR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

From: Coiby Xu <coxu@redhat.com>

Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
e.g. [1], it can lead to a linking error,

    ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
    security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

This happens because the actual implementation of
set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
function declaration and the empty stub definition are tied to
CONFIG_MODULES.

So bind set_module_sig_enforced to CONFIG_MODULE_SIG instead. This
allows (future) users to call set_module_sig_enforced directly without
the "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

Note this issue hasn't caused a real problem because all current callers
of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
use "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

[1] https://lore.kernel.org/lkml/20250928030358.3873311-1-coxu@redhat.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

---
From modules/modules-next
---
 include/linux/module.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d80c3ea57472..f288ca5cd95b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -770,8 +770,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-void set_module_sig_enforced(void);
-
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
 #else /* !CONFIG_MODULES... */
@@ -866,10 +864,6 @@ static inline bool module_requested_async_probing(struct module *module)
 }
 
 
-static inline void set_module_sig_enforced(void)
-{
-}
-
 /* Dereference module function descriptor */
 static inline
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
@@ -925,6 +919,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #ifdef CONFIG_MODULE_SIG
 bool is_module_sig_enforced(void);
 
+void set_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
@@ -935,6 +931,10 @@ static inline bool is_module_sig_enforced(void)
 	return false;
 }
 
+static inline void set_module_sig_enforced(void)
+{
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;

-- 
2.52.0


