Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5AB6BC2CC
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 01:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjCPAdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjCPAcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 20:32:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AFA64B3
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 17:31:32 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s11-20020a056a00194b00b0062586c7a2acso158368pfk.23
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKXEz6/mGmWtcTzhu61L6SyW9ch3P6ySrkhZdBbEs24=;
        b=bOjlcixbSYLhJ8wlZFJqykn9M5Vc0cFpb5g7LhT4djxRWIFNy4JccJg4iGmlnPSQyG
         lJkRIlzLGQZ3CT8tV3X05ZRlfpMlsWsYm10BZk0r/Rv+yvfQdYk0fGtvbClQaHHaYv5l
         Oj+/kJI0SJy2+jeH1DiW21OupNOPFM9Wh7wNdPPay5eUxl09yuqaKdEkkyKrOhWCrZJX
         e3EV/eGevF9LE/ooEptOTOPMZBAmj7BKZBkDjiPROvuVe+4bwZbAe4m1RyZsPF9uX6pM
         WIBv4RjDLE054xRE18NVAkWPZAWP+NMIosMPzwAwGqSXU4pxgbXQRbLdQ2u4zKCbVIO2
         DV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKXEz6/mGmWtcTzhu61L6SyW9ch3P6ySrkhZdBbEs24=;
        b=CiXg4QbWURIwuh9RqDs3xzZgCnHbqjceF8nPcPc01ZZ+2Zfo6iNxcN0P4LtQ1V6Q8i
         IcC9mqO7MfBACouAPbKY9nQX2M1N83K04TgqKTelFFLtHirMKTBTFYhgpijx7LAFK4JQ
         9YYTSbviLVoycHD3ilF2mG7mgf7E6NGdt6KUlK1xSctMcZik5QOWGKL9ATxL6gYBOjP2
         MTNWeWFqMFGTETYx+2hM1+sNg2yjHMz3SGbaEuGeo5qMAu3XmnfejK36KoCP7rbUIhdT
         JYiLLQ9jfWfS+u0j8DoyhjejcQKMk8kullvuG9tmNQ7D50UThuPEAKKWMZHDC3aRNvUt
         8APA==
X-Gm-Message-State: AO0yUKUw5j6Pl2YPFseKd7sZgUReXwbe2Hit9TpXMjjeu/r/4m0RjsrD
        pXWMCUQ1EmkSOtk28id+a0ODjQTvaS76TzfSMQ==
X-Google-Smtp-Source: AK7set8gW1ruUe+jZfx4vo3AOKGV2qgKk/o0c2WgfJNyT6l/gKi5/qNPPNY0SZ250Rg6tfQ0OBKmkU3mHKKgzrPR/w==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a65:6392:0:b0:50b:cc91:5534 with SMTP
 id h18-20020a656392000000b0050bcc915534mr320262pgv.2.1678926690322; Wed, 15
 Mar 2023 17:31:30 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:31:02 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <bdc28afc6bfba32441d6b6d17ec17318a64123ab.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 09/10] KVM: selftests: Add tests around sharing a
 restrictedmem fd
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tests that

+ Different memslots in the same VM should be able to share a
  restrictedmem_fd
+ A second VM cannot share the same offsets in a restrictedmem_fd
+ Different VMs should be able to share the same restrictedmem_fd, as
  long as the offsets in the restrictedmem_fd are different

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index cc727d11569e..789c413e2a67 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -401,7 +401,7 @@ static bool set_private_region_failed(struct kvm_vm *vm, void *hva,
 static void test_private_regions(void)
 {
 	int ret;
-	struct kvm_vm *vm;
+	struct kvm_vm *vm, *vm2;
 	void *mem;
 	int fd;
 
@@ -416,7 +416,7 @@ static void test_private_regions(void)
 
 	vm = __vm_create(shape, 1, 0);
 
-	mem = mmap(NULL, MEM_REGION_SIZE * 2, PROT_READ | PROT_WRITE,
+	mem = mmap(NULL, MEM_REGION_SIZE * 3, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
 	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
 
@@ -448,8 +448,31 @@ static void test_private_regions(void)
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "Set overlapping restrictedmem_offset should fail");
 
-	munmap(mem, MEM_REGION_SIZE * 2);
+	ret = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT + 1,
+					   KVM_MEM_PRIVATE,
+					   MEM_REGION_GPA + MEM_REGION_SIZE,
+					   MEM_REGION_SIZE,
+					   mem + MEM_REGION_SIZE,
+					   fd, MEM_REGION_SIZE);
+	TEST_ASSERT(!ret,
+		    "Different memslots should be able to share a restrictedmem_fd");
+
+	vm2 = __vm_create(shape, 1, 0);
+	TEST_ASSERT(set_private_region_failed(vm2, mem + 2 * MEM_REGION_SIZE, fd, 0),
+		    "Pages (offsets) of a restrictedmem_fd should be exclusive to a VM");
+
+	ret = __vm_set_user_memory_region2(vm2, MEM_REGION_SLOT,
+					   KVM_MEM_PRIVATE,
+					   MEM_REGION_GPA + 2 * MEM_REGION_SIZE,
+					   MEM_REGION_SIZE,
+					   mem + 2 * MEM_REGION_SIZE,
+					   fd, 2 * MEM_REGION_SIZE);
+	TEST_ASSERT(!ret,
+		    "Different VMs should be able to share a restrictedmem_fd");
+
+	munmap(mem, MEM_REGION_SIZE * 3);
 	kvm_vm_free(vm);
+	kvm_vm_free(vm2);
 }
 
 int main(int argc, char *argv[])
-- 
2.40.0.rc2.332.ga46443480c-goog

