Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A71AAEDB
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410553AbgDOQx2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410542AbgDOQxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:24 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B1D20857;
        Wed, 15 Apr 2020 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969602;
        bh=d0maaho1HljAyZxrBF/Y0MKWe+9/IRHQHs1rdMMn4mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pmxogfk0nmrARjyu7CTm63f6H3JcBqpKcpVTZkYR2L3BX7szsMuI1FOD632hm968T
         O9lEP6u+Pi9oY2VIdp6BoLQFZbrBJzjbWWOISOYZzB+jg2TpOkKvJbhaDPTl3NFSDl
         DmSiRza8X0gybXsJMQOhaw+5yiC2gSjfBsp37uzI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 12/12] gcov: Remove old GCC 3.4 support
Date:   Wed, 15 Apr 2020 17:52:18 +0100
Message-Id: <20200415165218.20251-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel requires at least GCC 4.8 in order to build, and so there is
no need to cater for the pre-4.7 gcov format.

Remove the obsolete code.

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/gcov/Kconfig   |  24 --
 kernel/gcov/Makefile  |   3 +-
 kernel/gcov/gcc_3_4.c | 573 ------------------------------------------
 3 files changed, 1 insertion(+), 599 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c48f83..feaad597b3f4 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,28 +51,4 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
-choice
-	prompt "Specify GCOV format"
-	depends on GCOV_KERNEL
-	depends on CC_IS_GCC
-	---help---
-	The gcov format is usually determined by the GCC version, and the
-	default is chosen according to your GCC version. However, there are
-	exceptions where format changes are integrated in lower-version GCCs.
-	In such a case, change this option to adjust the format used in the
-	kernel accordingly.
-
-config GCOV_FORMAT_3_4
-	bool "GCC 3.4 format"
-	depends on GCC_VERSION < 40700
-	---help---
-	Select this option to use the format defined by GCC 3.4.
-
-config GCOV_FORMAT_4_7
-	bool "GCC 4.7 format"
-	---help---
-	Select this option to use the format defined by GCC 4.7.
-
-endchoice
-
 endmenu
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index d66a74b0f100..16f8ecc7d882 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -2,6 +2,5 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-y := base.o fs.o
-obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
-obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
+obj-$(CONFIG_CC_IS_GCC) += gcc_base.o gcc_4_7.o
 obj-$(CONFIG_CC_IS_CLANG) += clang.o
diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
deleted file mode 100644
index acb83558e5df..000000000000
--- a/kernel/gcov/gcc_3_4.c
+++ /dev/null
@@ -1,573 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  This code provides functions to handle gcc's profiling data format
- *  introduced with gcc 3.4. Future versions of gcc may change the gcov
- *  format (as happened before), so all format-specific information needs
- *  to be kept modular and easily exchangeable.
- *
- *  This file is based on gcc-internal definitions. Functions and data
- *  structures are defined to be compatible with gcc counterparts.
- *  For a better understanding, refer to gcc source: gcc/gcov-io.h.
- *
- *    Copyright IBM Corp. 2009
- *    Author(s): Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
- *
- *    Uses gcc-internal data definitions.
- */
-
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/seq_file.h>
-#include <linux/vmalloc.h>
-#include "gcov.h"
-
-#define GCOV_COUNTERS		5
-
-static struct gcov_info *gcov_info_head;
-
-/**
- * struct gcov_fn_info - profiling meta data per function
- * @ident: object file-unique function identifier
- * @checksum: function checksum
- * @n_ctrs: number of values per counter type belonging to this function
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time.
- */
-struct gcov_fn_info {
-	unsigned int ident;
-	unsigned int checksum;
-	unsigned int n_ctrs[];
-};
-
-/**
- * struct gcov_ctr_info - profiling data per counter type
- * @num: number of counter values for this type
- * @values: array of counter values for this type
- * @merge: merge function for counter values of this type (unused)
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the values array.
- */
-struct gcov_ctr_info {
-	unsigned int	num;
-	gcov_type	*values;
-	void		(*merge)(gcov_type *, unsigned int);
-};
-
-/**
- * struct gcov_info - profiling data per object file
- * @version: gcov version magic indicating the gcc version used for compilation
- * @next: list head for a singly-linked list
- * @stamp: time stamp
- * @filename: name of the associated gcov data file
- * @n_functions: number of instrumented functions
- * @functions: function data
- * @ctr_mask: mask specifying which counter types are active
- * @counts: counter data per counter type
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the next pointer.
- */
-struct gcov_info {
-	unsigned int			version;
-	struct gcov_info		*next;
-	unsigned int			stamp;
-	const char			*filename;
-	unsigned int			n_functions;
-	const struct gcov_fn_info	*functions;
-	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[];
-};
-
-/**
- * gcov_info_filename - return info filename
- * @info: profiling data set
- */
-const char *gcov_info_filename(struct gcov_info *info)
-{
-	return info->filename;
-}
-
-/**
- * gcov_info_version - return info version
- * @info: profiling data set
- */
-unsigned int gcov_info_version(struct gcov_info *info)
-{
-	return info->version;
-}
-
-/**
- * gcov_info_next - return next profiling data set
- * @info: profiling data set
- *
- * Returns next gcov_info following @info or first gcov_info in the chain if
- * @info is %NULL.
- */
-struct gcov_info *gcov_info_next(struct gcov_info *info)
-{
-	if (!info)
-		return gcov_info_head;
-
-	return info->next;
-}
-
-/**
- * gcov_info_link - link/add profiling data set to the list
- * @info: profiling data set
- */
-void gcov_info_link(struct gcov_info *info)
-{
-	info->next = gcov_info_head;
-	gcov_info_head = info;
-}
-
-/**
- * gcov_info_unlink - unlink/remove profiling data set from the list
- * @prev: previous profiling data set
- * @info: profiling data set
- */
-void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
-{
-	if (prev)
-		prev->next = info->next;
-	else
-		gcov_info_head = info->next;
-}
-
-/**
- * gcov_info_within_module - check if a profiling data set belongs to a module
- * @info: profiling data set
- * @mod: module
- *
- * Returns true if profiling data belongs module, false otherwise.
- */
-bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
-{
-	return within_module((unsigned long)info, mod);
-}
-
-/* Symbolic links to be created for each profiling data file. */
-const struct gcov_link gcov_link[] = {
-	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
-	{ 0, NULL},
-};
-
-/*
- * Determine whether a counter is active. Based on gcc magic. Doesn't change
- * at run-time.
- */
-static int counter_active(struct gcov_info *info, unsigned int type)
-{
-	return (1 << type) & info->ctr_mask;
-}
-
-/* Determine number of active counters. Based on gcc magic. */
-static unsigned int num_counter_active(struct gcov_info *info)
-{
-	unsigned int i;
-	unsigned int result = 0;
-
-	for (i = 0; i < GCOV_COUNTERS; i++) {
-		if (counter_active(info, i))
-			result++;
-	}
-	return result;
-}
-
-/**
- * gcov_info_reset - reset profiling data to zero
- * @info: profiling data set
- */
-void gcov_info_reset(struct gcov_info *info)
-{
-	unsigned int active = num_counter_active(info);
-	unsigned int i;
-
-	for (i = 0; i < active; i++) {
-		memset(info->counts[i].values, 0,
-		       info->counts[i].num * sizeof(gcov_type));
-	}
-}
-
-/**
- * gcov_info_is_compatible - check if profiling data can be added
- * @info1: first profiling data set
- * @info2: second profiling data set
- *
- * Returns non-zero if profiling data can be added, zero otherwise.
- */
-int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
-{
-	return (info1->stamp == info2->stamp);
-}
-
-/**
- * gcov_info_add - add up profiling data
- * @dest: profiling data set to which data is added
- * @source: profiling data set which is added
- *
- * Adds profiling counts of @source to @dest.
- */
-void gcov_info_add(struct gcov_info *dest, struct gcov_info *source)
-{
-	unsigned int i;
-	unsigned int j;
-
-	for (i = 0; i < num_counter_active(dest); i++) {
-		for (j = 0; j < dest->counts[i].num; j++) {
-			dest->counts[i].values[j] +=
-				source->counts[i].values[j];
-		}
-	}
-}
-
-/* Get size of function info entry. Based on gcc magic. */
-static size_t get_fn_size(struct gcov_info *info)
-{
-	size_t size;
-
-	size = sizeof(struct gcov_fn_info) + num_counter_active(info) *
-	       sizeof(unsigned int);
-	if (__alignof__(struct gcov_fn_info) > sizeof(unsigned int))
-		size = ALIGN(size, __alignof__(struct gcov_fn_info));
-	return size;
-}
-
-/* Get address of function info entry. Based on gcc magic. */
-static struct gcov_fn_info *get_fn_info(struct gcov_info *info, unsigned int fn)
-{
-	return (struct gcov_fn_info *)
-		((char *) info->functions + fn * get_fn_size(info));
-}
-
-/**
- * gcov_info_dup - duplicate profiling data set
- * @info: profiling data set to duplicate
- *
- * Return newly allocated duplicate on success, %NULL on error.
- */
-struct gcov_info *gcov_info_dup(struct gcov_info *info)
-{
-	struct gcov_info *dup;
-	unsigned int i;
-	unsigned int active;
-
-	/* Duplicate gcov_info. */
-	active = num_counter_active(info);
-	dup = kzalloc(struct_size(dup, counts, active), GFP_KERNEL);
-	if (!dup)
-		return NULL;
-	dup->version		= info->version;
-	dup->stamp		= info->stamp;
-	dup->n_functions	= info->n_functions;
-	dup->ctr_mask		= info->ctr_mask;
-	/* Duplicate filename. */
-	dup->filename		= kstrdup(info->filename, GFP_KERNEL);
-	if (!dup->filename)
-		goto err_free;
-	/* Duplicate table of functions. */
-	dup->functions = kmemdup(info->functions, info->n_functions *
-				 get_fn_size(info), GFP_KERNEL);
-	if (!dup->functions)
-		goto err_free;
-	/* Duplicate counter arrays. */
-	for (i = 0; i < active ; i++) {
-		struct gcov_ctr_info *ctr = &info->counts[i];
-		size_t size = ctr->num * sizeof(gcov_type);
-
-		dup->counts[i].num = ctr->num;
-		dup->counts[i].merge = ctr->merge;
-		dup->counts[i].values = vmalloc(size);
-		if (!dup->counts[i].values)
-			goto err_free;
-		memcpy(dup->counts[i].values, ctr->values, size);
-	}
-	return dup;
-
-err_free:
-	gcov_info_free(dup);
-	return NULL;
-}
-
-/**
- * gcov_info_free - release memory for profiling data set duplicate
- * @info: profiling data set duplicate to free
- */
-void gcov_info_free(struct gcov_info *info)
-{
-	unsigned int active = num_counter_active(info);
-	unsigned int i;
-
-	for (i = 0; i < active ; i++)
-		vfree(info->counts[i].values);
-	kfree(info->functions);
-	kfree(info->filename);
-	kfree(info);
-}
-
-/**
- * struct type_info - iterator helper array
- * @ctr_type: counter type
- * @offset: index of the first value of the current function for this type
- *
- * This array is needed to convert the in-memory data format into the in-file
- * data format:
- *
- * In-memory:
- *   for each counter type
- *     for each function
- *       values
- *
- * In-file:
- *   for each function
- *     for each counter type
- *       values
- *
- * See gcc source gcc/gcov-io.h for more information on data organization.
- */
-struct type_info {
-	int ctr_type;
-	unsigned int offset;
-};
-
-/**
- * struct gcov_iterator - specifies current file position in logical records
- * @info: associated profiling data
- * @record: record type
- * @function: function number
- * @type: counter type
- * @count: index into values array
- * @num_types: number of counter types
- * @type_info: helper array to get values-array offset for current function
- */
-struct gcov_iterator {
-	struct gcov_info *info;
-
-	int record;
-	unsigned int function;
-	unsigned int type;
-	unsigned int count;
-
-	int num_types;
-	struct type_info type_info[];
-};
-
-static struct gcov_fn_info *get_func(struct gcov_iterator *iter)
-{
-	return get_fn_info(iter->info, iter->function);
-}
-
-static struct type_info *get_type(struct gcov_iterator *iter)
-{
-	return &iter->type_info[iter->type];
-}
-
-/**
- * gcov_iter_new - allocate and initialize profiling data iterator
- * @info: profiling data set to be iterated
- *
- * Return file iterator on success, %NULL otherwise.
- */
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
-{
-	struct gcov_iterator *iter;
-
-	iter = kzalloc(struct_size(iter, type_info, num_counter_active(info)),
-		       GFP_KERNEL);
-	if (iter)
-		iter->info = info;
-
-	return iter;
-}
-
-/**
- * gcov_iter_free - release memory for iterator
- * @iter: file iterator to free
- */
-void gcov_iter_free(struct gcov_iterator *iter)
-{
-	kfree(iter);
-}
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
-{
-	return iter->info;
-}
-
-/**
- * gcov_iter_start - reset file iterator to starting position
- * @iter: file iterator
- */
-void gcov_iter_start(struct gcov_iterator *iter)
-{
-	int i;
-
-	iter->record = 0;
-	iter->function = 0;
-	iter->type = 0;
-	iter->count = 0;
-	iter->num_types = 0;
-	for (i = 0; i < GCOV_COUNTERS; i++) {
-		if (counter_active(iter->info, i)) {
-			iter->type_info[iter->num_types].ctr_type = i;
-			iter->type_info[iter->num_types++].offset = 0;
-		}
-	}
-}
-
-/* Mapping of logical record number to actual file content. */
-#define RECORD_FILE_MAGIC	0
-#define RECORD_GCOV_VERSION	1
-#define RECORD_TIME_STAMP	2
-#define RECORD_FUNCTION_TAG	3
-#define RECORD_FUNCTON_TAG_LEN	4
-#define RECORD_FUNCTION_IDENT	5
-#define RECORD_FUNCTION_CHECK	6
-#define RECORD_COUNT_TAG	7
-#define RECORD_COUNT_LEN	8
-#define RECORD_COUNT		9
-
-/**
- * gcov_iter_next - advance file iterator to next logical record
- * @iter: file iterator
- *
- * Return zero if new position is valid, non-zero if iterator has reached end.
- */
-int gcov_iter_next(struct gcov_iterator *iter)
-{
-	switch (iter->record) {
-	case RECORD_FILE_MAGIC:
-	case RECORD_GCOV_VERSION:
-	case RECORD_FUNCTION_TAG:
-	case RECORD_FUNCTON_TAG_LEN:
-	case RECORD_FUNCTION_IDENT:
-	case RECORD_COUNT_TAG:
-		/* Advance to next record */
-		iter->record++;
-		break;
-	case RECORD_COUNT:
-		/* Advance to next count */
-		iter->count++;
-		/* fall through */
-	case RECORD_COUNT_LEN:
-		if (iter->count < get_func(iter)->n_ctrs[iter->type]) {
-			iter->record = 9;
-			break;
-		}
-		/* Advance to next counter type */
-		get_type(iter)->offset += iter->count;
-		iter->count = 0;
-		iter->type++;
-		/* fall through */
-	case RECORD_FUNCTION_CHECK:
-		if (iter->type < iter->num_types) {
-			iter->record = 7;
-			break;
-		}
-		/* Advance to next function */
-		iter->type = 0;
-		iter->function++;
-		/* fall through */
-	case RECORD_TIME_STAMP:
-		if (iter->function < iter->info->n_functions)
-			iter->record = 3;
-		else
-			iter->record = -1;
-		break;
-	}
-	/* Check for EOF. */
-	if (iter->record == -1)
-		return -EINVAL;
-	else
-		return 0;
-}
-
-/**
- * seq_write_gcov_u32 - write 32 bit number in gcov format to seq_file
- * @seq: seq_file handle
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file.
- */
-static int seq_write_gcov_u32(struct seq_file *seq, u32 v)
-{
-	return seq_write(seq, &v, sizeof(v));
-}
-
-/**
- * seq_write_gcov_u64 - write 64 bit number in gcov format to seq_file
- * @seq: seq_file handle
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. 64 bit numbers are stored as two 32 bit numbers, the low part
- * first.
- */
-static int seq_write_gcov_u64(struct seq_file *seq, u64 v)
-{
-	u32 data[2];
-
-	data[0] = (v & 0xffffffffUL);
-	data[1] = (v >> 32);
-	return seq_write(seq, data, sizeof(data));
-}
-
-/**
- * gcov_iter_write - write data for current pos to seq_file
- * @iter: file iterator
- * @seq: seq_file handle
- *
- * Return zero on success, non-zero otherwise.
- */
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
-{
-	int rc = -EINVAL;
-
-	switch (iter->record) {
-	case RECORD_FILE_MAGIC:
-		rc = seq_write_gcov_u32(seq, GCOV_DATA_MAGIC);
-		break;
-	case RECORD_GCOV_VERSION:
-		rc = seq_write_gcov_u32(seq, iter->info->version);
-		break;
-	case RECORD_TIME_STAMP:
-		rc = seq_write_gcov_u32(seq, iter->info->stamp);
-		break;
-	case RECORD_FUNCTION_TAG:
-		rc = seq_write_gcov_u32(seq, GCOV_TAG_FUNCTION);
-		break;
-	case RECORD_FUNCTON_TAG_LEN:
-		rc = seq_write_gcov_u32(seq, 2);
-		break;
-	case RECORD_FUNCTION_IDENT:
-		rc = seq_write_gcov_u32(seq, get_func(iter)->ident);
-		break;
-	case RECORD_FUNCTION_CHECK:
-		rc = seq_write_gcov_u32(seq, get_func(iter)->checksum);
-		break;
-	case RECORD_COUNT_TAG:
-		rc = seq_write_gcov_u32(seq,
-			GCOV_TAG_FOR_COUNTER(get_type(iter)->ctr_type));
-		break;
-	case RECORD_COUNT_LEN:
-		rc = seq_write_gcov_u32(seq,
-				get_func(iter)->n_ctrs[iter->type] * 2);
-		break;
-	case RECORD_COUNT:
-		rc = seq_write_gcov_u64(seq,
-			iter->info->counts[iter->type].
-				values[iter->count + get_type(iter)->offset]);
-		break;
-	}
-	return rc;
-}
-- 
2.26.0.110.g2183baf09c-goog

